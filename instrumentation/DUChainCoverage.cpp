#include <iostream>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/IntrinsicInst.h>

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/Analysis/IteratedDominanceFrontier.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include <vector>
#include <string>

using namespace llvm;

namespace {
    
    class DUChainCoverage {
        protected:
            static const char instrumentationFunctionName[];
            
            Module &module;
            FunctionType *functionType;
            Function *hook;
            
            void setupHooks ( );
            bool instrumentBeforeInstruction ( Instruction*, int );
        public:
            DUChainCoverage ( Module &module ) : module ( module ) { };
            bool apply ( );
    };
    
    const char DUChainCoverage::instrumentationFunctionName[] = "__print_du_chain";
    
    void DUChainCoverage::setupHooks ( ) {
        LLVMContext &llvmContext = this->module.getContext ( );
        
        Type *voidType = Type::getVoidTy ( llvmContext );
        Type *charPointerType = Type::getInt8PtrTy ( llvmContext );
        
        this->functionType = FunctionType::get ( voidType, charPointerType, false );
        
        Function::Create (functionType, GlobalValue::ExternalLinkage )->setName ( DUChainCoverage::instrumentationFunctionName );
        
        this->hook = dyn_cast<Function> ( this->module.getOrInsertFunction ( DUChainCoverage::instrumentationFunctionName, functionType ) );
    }
    
    bool DUChainCoverage::instrumentBeforeInstruction ( Instruction *instruction, int instructionNumber ) {
        // check whether the instruction uses any of the previous definitions
        int numInstructionOperands = 0;
        
        for ( unsigned int i = 0; i < instruction->getNumOperands ( ); ++i ) {
            if ( isa<Instruction> ( instruction->getOperand ( i ) ) ) {
                numInstructionOperands++;
            }
        }
        
        if ( numInstructionOperands == 0 ) {
            return false;
        }
        
        // build DU chains tring
        
        std::string argument ( "USE NUMBER " + std::to_string ( instructionNumber ) + " : \n\t" );
        raw_string_ostream instructionOutStream ( argument );
        
        instruction->print ( instructionOutStream, false );
        
        argument.append ( "\nDEFINITIONS: \n " );
        
        for ( unsigned int i = 0; i < instruction->getNumOperands ( ); ++i ) {
            if ( Instruction *operand = dyn_cast<Instruction> ( instruction->getOperand ( i ) ) ) {
                argument.append ( "\t" );
                operand->print ( instructionOutStream, false );
                argument.append ( "\n" );
            }
        }
        
        Type *int8Type = Type::getInt8Ty ( this->module.getContext ( ) );
        IRBuilder<> builder ( this->module.getContext ( ) );
        
        builder.SetInsertPoint ( instruction );
        builder.CreateCall ( this->hook, builder.CreateGlobalStringPtr ( StringRef ( argument ) ) );
        return true;
    }
    
    bool DUChainCoverage::apply ( ) {
        raw_ostream &out = errs ( );
        bool changed = false;
        
        this->setupHooks ( );
    
        int instructionNumber = 0;
        for ( Function &function : this->module ) {
            for ( inst_iterator i = inst_begin ( function ); i != inst_end ( function ); ++i ) {
                changed |= this->instrumentBeforeInstruction ( &( *i ), instructionNumber );
                instructionNumber++;
            }
        }
        
        return changed;
    }
    
    struct DUChainCoverageWrapperPass : public ModulePass {
        static char ID;
        
        DUChainCoverageWrapperPass ( ) : ModulePass ( ID ) { }
        
        bool runOnModule ( Module &module ) override {
            return DUChainCoverage (
                module
            ).apply ( );
        }
    };
}

char DUChainCoverageWrapperPass::ID = 0;
static RegisterPass<DUChainCoverageWrapperPass> registraion0(
        "duc",
        "DUChainCoverage Pass"
);
