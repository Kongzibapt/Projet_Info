D [0-9]
N [a-zA-Z]([a-zA-Z0-9_])*

%%

"main"                   ECHO;
"{"                      ECHO;
"}"                      ECHO;
{N}                      ECHO;
const                    ECHO;
int                      ECHO;
"+"                      ECHO;
"-"                      ECHO;
"*"                      ECHO;
"/"                      ECHO;
"="                      ECHO;
"("                      ECHO;
")"                      ECHO;
" "                      ECHO;
\t                       ECHO;
,                        ECHO;
\n                       ECHO;
;                        ECHO;
printf                   ECHO;
{D}+                     ECHO;
exp                      ECHO;
.                        {};

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