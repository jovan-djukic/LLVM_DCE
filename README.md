This repository contains the code of a school project.
The goal of the project was to implement a Dead Code Elimination compiler optimization.
Folder instrumentation contains contains a LLVM pass implementation that prints all Define-Use chains in the code.
Folder deadCodedElimination contains a LLVM pass implementation that eliminates the dead code based on the DU chains.
All test cases also include .dot files which depict basic block graphs that represent the code after applying a certain pass.

Notes:
    - If a file with the LLVM IR has a mem2reg suffix in its name it means that the mem2reg pass has been applied (already available).
    - If a file with the LLVM IR has a adce suffix in its name it means that the Advanced Dead Code Elimination was applied (already available).
    - If a file with the LLVM IR has a simplifycfg suffix in its name it means that simplifycfg pass was applied (already available).
    - If a file with the LLVM IR has a dce suffix in its name it means that my implementation of a DCE pass was applied.