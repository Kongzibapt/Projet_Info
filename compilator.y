%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
#include "comp.h"
#include "code.h"
#include <string.h>

int type; //0 is const, 2 is temp et 1 is int
int depth; 

char* var[26];
void yyerror(char *s);
%}
%union { int nb; char * var; }
%token tMAIN tOB tCB tCONST tINT tADD tSUB tMUL tDIV tEQ tOP tCP tSPACE tTAB tCOMMA tENDL tSEMI tPRINT tMULTDEF tERROR tIF tELSE tWHILE tSUP tINF tNOT tAND tOR
%token <nb> tINTVAL
%token <var> tID
%right '='
%left '+''-'
%left '*' '/'
%start Compilator
%%
Compilator : tMAIN {flush_file();} tOP tCP tOB Code tCB {printf("main\n");depth=0;};
Code : Declarations Instructions {printf("declaAndInstrs\n");}
      | Declarations {printf("declas\n");} 
      | Instructions {printf("instrs\n");};
Declarations : Declaration Declarations {printf("declas\n");} 
      | Declaration {printf("decla\n");};
Declaration :
        tCONST { type = 0; } Variables tSEMI {printf("const\n");}
      | tINT { type = 1; }  Variables tSEMI {printf("Int\n");};
Variables : tID { 
                  newInt($1);
                  printf("Variables\n");}
      | tID { newInt($1); } tCOMMA Variables {printf("variablesMul\n");}
      | tID tEQ Expr {newInt($1); compAffectation($1); };

Instructions : Instruction Instructions {printf("instrs\n");}
      | Instruction {printf("instr\n");};
Instruction : Calcul {printf("calc\n");} 
      | Func {printf("func\n");}
      | Bloc {printf("bloc\n");};  
Calcul : Expr tSEMI {printf("expr\n");}
      | tID tEQ Expr tSEMI {compAffectation($1); freeTemp();};
Expr : Mul {printf("condmul\n");}
      | Add {printf("condadd\n");}
      | Sub {printf("condsub\n");}
      | Div {printf("conddiv\n");}
      | Terme {printf("condterm\n");};   
Mul : Expr tMUL Expr {compMul();};
Add : Expr tADD Expr {compAdd();};
Sub : Expr tSUB Expr {compSub();};
Div : Expr tDIV Expr {compDiv();};

Terme : tOP Expr tCP {}
      | tID {compArithID($1);}
      | tINTVAL {compArithNB($1);};

Func : Print tSEMI {printf("funcprintsemi\n");}
Bloc:  If {printf("if\n");}
      | If Else {printf("ifelse\n");}
      | If ElseIf {printf("elseif\n");}
      | While {printf("while\n");};
Print : tPRINT tOP tID tCP {compPrintID($3);};
If : tIF tOP Cond tCP tOB {depth++;} Code tCB {printf("blocif\n");popSymbol(depth);depth--;};
Else : tELSE tOB {depth++;} Code tCB {printf("blocelse\n");popSymbol(depth);depth--;};

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
Inf : CondPart tINF CondPart {compInf();};
Sup : CondPart tSUP CondPart {compSup();};
Eq : CondPart tEQ tEQ CondPart {compEqu();};
InfEq : CondPart tINF tEQ CondPart {printf("infeq\n");};
SupEq : CondPart tSUP tEQ CondPart {printf("supeq\n");};
Diff : CondPart tNOT tEQ CondPart {printf("diff\n");};
And : CondPart tAND CondPart {printf("and\n");};
Or : CondPart tOR CondPart {printf("or\n");};
Not : tNOT CondPart {printf("not\n");};
CondPart : Expr {printf("condExpr\n");} | tOP Cond tCP {printf("condPart\n");};
While : tWHILE tOP Cond tCP tOB {depth++;} Code tCB {printf("contenublocwhile\n");popSymbol(depth);depth--;};
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
  printf("Compilateur\n"); // yydebug=1;
  createStackSymbols();
  yyparse();
  print_stack(); 
  printTI();
  return 0;
}