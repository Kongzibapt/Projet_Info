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
Compilator : tMAIN tOP tCP tOB Code tCB {printf("main\n");depth=0;};
Code : Declarations Instructions {printf("declaAndInstrs\n");}
      | Declarations {printf("declas\n");} 
      | Instructions {printf("instrs\n");};
Declarations : Declaration Declarations {printf("declas\n");} 
      | Declaration {printf("decla\n");};
Declaration :
        tCONST { type = 0; } Variables tSEMI {printf("const\n");}
      | tINT { type = 1; }  Variables tSEMI {printf("Int\n");};
Variables : tID { 
                  compAddSymbol($1, type,depth);
                  printf("Variables\n");}
      | tID { compAddSymbol($1, type,depth); } tCOMMA Variables {printf("variablesMul\n");}
      | tID tEQ Expr {compAddSymbol($1, type,depth);printf("declaexp\n");};
Instructions : Instruction Instructions {printf("instrs\n");}
      | Instruction {printf("instr\n");};
Instruction : Calcul {printf("calc\n");} 
      | Func {printf("func\n");}
      | Bloc {printf("bloc\n");};  
Calcul : Expr tSEMI {printf("expr\n");}
      | tID tEQ Expr tSEMI {printf("varEqExpr\n");freeTemp();};
Expr : Mul {printf("condmul\n");}
      | Add {printf("condadd\n");}
      | Sub {printf("condsub\n");}
      | Div {printf("conddiv\n");}
      | Terme {printf("condterm\n");};   
Mul : Expr tMUL Expr {printf("mul\n");};
Add : Expr tADD Expr {printf("add\n");};
Sub : Expr tSUB Expr {printf("sub\n");};
Div : Expr tDIV Expr {printf("div\n");};
Terme : tOP Expr tCP {printf("parentExpr\n");}
      | tID {printf("id\n");find_symbol($1);compAddSymbol("",2,depth);}
      | tINTVAL {printf("val\n");type = 2;compAddSymbol("",2,depth);};
Func : Print tSEMI {printf("funcprintsemi\n");}
Bloc:  If {printf("if\n");}
      | If Else {printf("ifelse\n");}
      | If ElseIf {printf("elseif\n");}
      | While {printf("while\n");};
Print : tPRINT tOP tID {compAddSymbol("",2,depth);} tCP {put_instruction(0);};
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
While : tWHILE tOP Cond tCP tOB {depth++;} Code tCB {printf("contenublocwhile\n");popSymbol(depth);depth--;};
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
  printf("Compilateur\n"); // yydebug=1;
  createStackSymbols();
  yyparse();
  print_stack(); 
  return 0;
}