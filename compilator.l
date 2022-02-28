D [0-9]
N [a-zA-Z]([a-zA-Z0-9_])*

%%

"main"                   return tMAIN;
"{"                      return tOB;
"}"                      return tCB;
{N}                      return {yylval.var = yytext[0]; return tID;}
const                    return tCONST;
int                      return tINT;
"+"                      return tADD;
"-"                      return tSUB;
"*"                      return tMUL;
"/"                      return tDIV;
"="                      return tEQ;
"("                      return tOP;
")"                      return tCP;
" "                      return tSPACE;
\t                       return tTAB;
,                        return tCOMMA;
\n                       return tENDL;
;                        return tSEMI;
printf                   return tPRINT;
{D}+                     {yylval.nb = atoi(yytext); return tINTVAL;}
.                        return {return tERROR;};

%%

int yywrap()
{
return 1 ;
}
int main ()
{
yylex() ;
return 1 ;
}