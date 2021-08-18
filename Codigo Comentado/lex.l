%{ /*Seccion Declaraciones*/
    #include "y.tab.h"
    #include <stdio.h>
%}

%option yylineno 

entero [0-9]
real {entero}*\.?{entero}*
letra [a-zA-Z]*
id {letra}*
crlf "\n"
/*Seccion Declaraciones
%%
{real}      {yylval.numero = atoi(yytext); 
                return REAL;} /*convierte la cadena en un numero para que yacc lo reconozca*/
{id}        {strcpy(yylval.identificador, yytext); 
                return ID;} /*Pone en la posicion identificador a la cadena para que recibilo yacc*/
"+"|"-"     return OPE;
"("         return PARIZQ;
")"         return PARDER;
{crlf}      return CRLF; /*Manda un salto de linea para que pueda leer la siguiente cadena*/
[\t\r. ]  {} /*No hace nada*/
%%
