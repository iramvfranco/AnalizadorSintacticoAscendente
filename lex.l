%{ 
    #include "y.tab.h"
    #include <stdio.h>
%}

%option yylineno 

entero [0-9]
real {entero}*\.?{entero}*
letra [a-zA-Z]*
id {letra}*
crlf "\n"

%%
{real}      {yylval.numero = atoi(yytext); 
                return REAL;} 
{id}        {strcpy(yylval.identificador, yytext); 
                return ID;}
"+"|"-"     return OPE;
"("         return PARIZQ;
")"         return PARDER;
{crlf}      return CRLF; 
[\t\r\f.]   {}
%%
