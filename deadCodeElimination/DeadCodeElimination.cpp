#include <iostream>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/IntrinsicInst.h>

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/Analysis/IteratedDominanceFrontier.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include <set>

using namespace llvm;

namespace {
    
    class MarkAndSweepDCE {
        protected:
            
            Function &function;
            PostDominatorTree &postDominatorTree;
            
            std::set<Instruction*> aliveInstructions;
            std::set<BasicBlock*> aliveBasicBlocks;
            std::vector<Instruction*> instructionWorkList;
            
            bool isLive ( Instruction & );
            void mark ( Instruction * );
            SmallVector<BasicBlock*, 32> getControlDependencies ( BasicBlock* );
            void initialize ( );
            void mark ( );
            bool sweep ( );
        public:
            MarkAndSweepDCE (
                Function &function,
                PostDominatorTree &postDominatorTree
            ) : function ( function ),
                postDominatorTree ( postDominatorTree ) { }
            
            bool apply ( );
    };
    
    bool MarkAndSweepDCE::isLive ( Instruction &instruction ) {
        if ( isa<ReturnInst> ( instruction ) ) {
            return true;
        } else if ( instruction.mayHaveSideEffects ( ) ) {
            if ( instruction.mayWriteToMemory ( ) )  {
                if ( isa<StoreInst> ( instruction ) ) {
                    bool isOperandGlobal                  = false;
                    bool isOperandArgumentPassedByPointer = false;
                    
                    for ( unsigned int i = 0; i < instruction.getNumOperands ( ); ++i ) {
                        Value *value = instruction.getOperand ( i );
                        
                        if ( isa<GlobalVariable> ( value ) ) {
                            isOperandGlobal = true;
                        }
                        
                        if ( Argument *argument = dyn_cast<Argument> ( value ) ) {
                            if ( isa<PointerType> ( argument->getType ( ) ) ) {
                                isOperandArgumentPassedByPointer = true;
                            }
                        }
                    }
    
                    return isOperandGlobal || isOperandArgumentPassedByPointer;
                } else {
                    return true;
                }
            } else {
                return true;
            }
        }
        return false;
    }
    
    void MarkAndSweepDCE::mark ( Instruction *instruction ) {
        // mark instructions as live
        bool isInserted = this->aliveInstructions.insert ( instruction ).second;
        
        if ( isInserted ) {
            // mark block as live
            this->aliveBasicBlocks.insert ( instruction->getParent ( ));
    
            // add the instruction to work list
            this->instructionWorkList.push_back ( instruction );
        }
    }
    
    void MarkAndSweepDCE::initialize ( ) {
        raw_ostream &out = errs ( );
    
        // initial live run
        for ( inst_iterator i = inst_begin ( this->function ); i != inst_end ( this->function ); ++i ) {
            Instruction &instruction = *i;
        
            if ( isLive ( instruction ) ) {
                this->mark ( &instruction );
            }
        }
    }
    
    // helper function to get control dependencies of a basic block
    SmallVector<BasicBlock*, 32> MarkAndSweepDCE::getControlDependencies ( BasicBlock *basicBlock ) {
        SmallVector<BasicBlock*, 32> controlDependencies;
        SmallPtrSet<BasicBlock*, 32> basicBlocks;
        ReverseIDFCalculator reverseIDFCalculator ( this->postDominatorTree );
       
        basicBlocks.insert ( basicBlock );
        reverseIDFCalculator.setDefiningBlocks ( basicBlocks );
        reverseIDFCalculator.calculate ( controlDependencies );
        return controlDependencies;
    }
    
    void MarkAndSweepDCE::mark ( ) {
        raw_ostream &out = errs ( );
        // iterate until the worklist is empty
        while ( !this->instructionWorkList.empty ( ) ) {
            // get current instruction
            Instruction *currentInstruction = this->instructionWorkList.back ( );
            this->instructionWorkList.pop_back ( );
            
            // mark operands of current instruction
            for ( unsigned int i = 0; i < currentInstruction->getNumOperands ( ); ++i ) {
                if ( Instruction *operand = dyn_cast<Instruction> ( currentInstruction->getOperand ( i ) ) ) {
                    this->mark ( operand );
                }
            }
            
            // handle phi node case, mark branches in all predecessors
            if ( PHINode *phiNode = dyn_cast<PHINode> ( currentInstruction ) ) {
                for ( BasicBlock *basicBlock : predecessors ( phiNode->getParent ( ) ) ) {
                    Instruction *terminator = basicBlock->getTerminator ( );
                    if ( this->aliveInstructions.insert ( terminator ).second ) {
                        this->instructionWorkList.push_back ( terminator );
                    }
                }
            }
           
            // get control dependencies and mark branches to ensure that the current live block is executed
            SmallVector<BasicBlock*, 32> controlDependencies = this->getControlDependencies ( currentInstruction->getParent ( ) );
            for ( BasicBlock *basicBlock : controlDependencies ) {
                Instruction *terminator = basicBlock->getTerminator ( );
                
                this->mark ( terminator );
            }
        }
    }
    
    bool MarkAndSweepDCE::sweep ( ) {
        raw_ostream &out = errs ( );
        std::vector<Instruction*> deadInstructions;
        
        for ( inst_iterator i = inst_begin ( this->function ); i != inst_end ( this->function ); ++i ) {
            Instruction &currentInstruction = *i;
            
            if ( this->aliveInstructions.find ( &currentInstruction ) == this->aliveInstructions.end ( ) ) {
                if ( TerminatorInst *terminator = dyn_cast<TerminatorInst> ( &currentInstruction ) ) {
                    if ( BranchInst *branch = dyn_cast<BranchInst> ( terminator ) ) {
                        if ( !branch->isUnconditional ( ) ) {
                            // get post dominator tree node
                            DomTreeNodeBase < BasicBlock > *node = this->postDominatorTree.getNode ( branch->getParent ( ) )->getIDom ( );
    
                            // traverse from that node to root until either a useful postdominator is found or root is reached
                            while ( node != nullptr && ( this->aliveBasicBlocks.find ( node->getBlock ( )) == this->aliveBasicBlocks.end ( ))) {
                                node = node->getIDom ( );
                            }
    
                            // if there is a useful post dominator rewrite the branch so it jumps to it
                            if ( node != nullptr ) {
                                BranchInst *unconditionalBranch = BranchInst::Create ( node->getBlock ( ), branch );
                                branch->dropAllReferences ( );
                                deadInstructions.push_back ( branch );
                            }
                        }
                    }
                } else {
                    currentInstruction.dropAllReferences ( );
                    deadInstructions.push_back ( &currentInstruction );
                }
            }
        }
        
        for ( Instruction *instruction : deadInstructions ) {
           instruction->eraseFromParent ( );
        }
        return deadInstructions.size ( ) != 0;
    }
    
    bool MarkAndSweepDCE::apply ( ) {
        this->initialize ( );
        this->mark ( );
        bool changed = this->sweep ( );
        return changed;
    }
    
    struct MarkAndSweepDCEWrapper : public FunctionPass {
        static char ID;
        
        MarkAndSweepDCEWrapper ( ) : FunctionPass ( ID ) { }
        
        bool runOnFunction ( Function &function ) override {
            raw_ostream &out = errs ( );
    
            PostDominatorTree &postDominatorTree = this->getAnalysis<PostDominatorTreeWrapperPass> ( ).getPostDomTree ( );
            
            return MarkAndSweepDCE (
                function,
                postDominatorTree
            ).apply ( );
        }
        
        void getAnalysisUsage ( AnalysisUsage &analysisUsage ) const override {
            analysisUsage.addRequired<PostDominatorTreeWrapperPass> ( );
        }
    };
}

char MarkAndSweepDCEWrapper::ID = 0;
static RegisterPass<MarkAndSweepDCEWrapper> registraion0(
        "msdce",
        "MarkAndSweepDCE Pass"
);
