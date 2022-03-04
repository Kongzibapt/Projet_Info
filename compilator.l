%{
#include "y.tab.h"
%}

D [0-9]
N [a-zA-Z]([a-zA-Z0-9_])*

%%

main                     return tMAIN;
"{"                      return tOB;
"}"                      return tCB;
const                    return tCONST;
int                      return tINT;
"+"                      return tADD;
"-"                      return tSUB;
"*"                      return tMUL;
"/"                      return tDIV;
"="                      return tEQ;
"("                      return tOP;
")"                      return tCP;
">"                      return tSUP;
"<"                      return tINF;
"!"                      return tNOT;
"&&"                     return tAND;
"||"                     return tOR;
[ \t\n]+                      ;                   
,                        return tCOMMA;
;                        return tSEMI;
printf                   return tPRINT;
if                       return tIF;
while                    return tWHILE;
else                     return tELSE;
{D}+                     {yylval.nb = atoi(yytext); return tINTVAL;}
{N}                      {yylval.var = yytext[0]; return tID;}
.                        return tERROR;

%%

int yywrap()
{
return 1 ;
}
