%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
#include "comp.h"
#include <string.h>

int type; //0 is const et is int

char* var[26];
void yyerror(char *s);
%}
%union { int nb; char * var; }
%token tMAIN tOB tCB tCONST tINT tADD tSUB tMUL tDIV tEQ tOP tCP tSPACE tTAB tCOMMA tENDL tSEMI tPRINT tMULTDEF tERROR tIF tELSE tWHILE tSUP tINF tNOT tAND tOR
%token <nb> tINTVAL
%token <var> tID
%start Compilator
%%
Compilator : tMAIN tOP tCP tOB Code tCB {printf("main\n");};
Code : Declarations Instructions {printf("declaAndInstrs\n");}
      | Declarations {printf("declas\n");} 
      | Instructions {printf("instrs\n");};
Declarations : Declaration Declarations {printf("declas\n");} 
      | Declaration {printf("decla\n");};
Declaration :
        tCONST { type = 0; } Variables tSEMI {printf("const\n");}
      | tINT { type = 1; }  Variables tSEMI {printf("Int\n");};
Variables : tID { 
                  compAddSymbol($1, type);
                  printf("Variables\n");}
      | tID { compAddSymbol($1, type); } tCOMMA Variables {printf("variablesMul\n");}
      | tID tEQ Expr {compAddSymbol($1, type);printf("declaexp\n");};
Instructions : Instruction Instructions {printf("instrs\n");}
      | Instruction {printf("instr\n");};
Instruction : Calcul {printf("calc\n");} 
      | Func {printf("func\n");}
      | Bloc {printf("bloc\n");};  
Calcul : Expr tSEMI {printf("expr\n");}
      | tID tEQ Expr tSEMI {printf("varEqExpr\n");};
Expr : Expr tADD DivMul {printf("add\n");}
      | Expr tSUB DivMul {printf("sub\n");}
      | DivMul {printf("divmul\n");};
DivMul : DivMul tMUL Terme {printf("mul\n");}
      | DivMul tDIV Terme {printf("div\n");}
      | Terme {printf("terme\n");};
Terme : tOP Expr tCP {printf("parentExpr\n");}
      | tID {printf("id\n");}
      | tINTVAL {printf("val\n");};
Func : Print tSEMI {printf("funcprintsemi\n");}
Bloc:  If {printf("if\n");}
      | If Else {printf("ifelse\n");}
      | If ElseIf {printf("elseif\n");}
      | While {printf("while\n");};
Print : tPRINT tOP tID tCP {printf("funcprint\n");};
If : tIF tOP Cond tCP tOB Code tCB {printf("blocif\n");};
Else : tELSE tOB Code tCB {printf("blocelse\n");};

ElseIf : tELSE If {printf("contenublocifelse\n");}
      |tELSE If ElseIf {printf("contenublocifelseMul\n");};
      |tELSE If Else {printf("elseifelse\n");}
Cond : Inf {printf("condInf\n");} 
      | Sup {printf("condSup\n");}
      | Eq {printf("condEq\n");}
      | InfEq {printf("condInfEq\n");}
      | SupEq {printf("condSupEq\n");}
      | Diff {printf("condDiff\n");}
      | And {printf("condAnd\n");}
      | Or {printf("condOr\n");}
      | Not {printf("condNot\n");}
      | Expr {printf("condexpr\n");};
Inf : CondPart tINF CondPart {printf("inf\n");};
Sup : CondPart tSUP CondPart {printf("sup\n");};
Eq : CondPart tEQ tEQ CondPart {printf("eq\n");};
InfEq : CondPart tINF tEQ CondPart {printf("infeq\n");};
SupEq : CondPart tSUP tEQ CondPart {printf("supeq\n");};
Diff : CondPart tNOT tEQ CondPart {printf("diff\n");};
And : CondPart tAND CondPart {printf("and\n");};
Or : CondPart tOR CondPart {printf("or\n");};
Not : tNOT CondPart {printf("not\n");};
CondPart : Expr {printf("condExpr\n");} | tOP Cond tCP {printf("condPart\n");};
While : tWHILE tOP Cond tCP tOB Code tCB {printf("contenublocwhile\n");};
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
  printf("Compilateur\n"); // yydebug=1;
  createStackSymbols();
  yyparse();
  print_stack(); 
  return 0;
}