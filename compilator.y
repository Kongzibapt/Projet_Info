%union { int nb; char var; }
%token tMAIN tOB tCB tCONST tINT tADD tSUB tMUL tDIV tEQ tOP tCP tSPACE tTAB tCOMMA tENDL tSEMI tPRINT tINTVAL tMULTDEF
%token <nb> tINTVAL
%token <var> tID
%start Compilator
%%
Compilator : tMAIN tOP tCP tOB Code tCB;
Code : Declarations Instructions | Declarations | Instructions;
Declarations : Declaration Declarations | Declaration;
Declaration : tCONST tID tEQ tINTVAL tSEMI | tCONST tID tEQ tSEMI 
              tINT tID tEQ tINTVAL tSEMI | tINT tID tEQ tSEMI;
Instructions : Instruction Instructions | Instruction;
Instruction : Add
Add : tID 