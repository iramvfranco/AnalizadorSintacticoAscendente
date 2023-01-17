%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token ADD REMOVE
%token ITEM
%token COMMA

%%

list : /* empty */
     | list command
     ;

command : ADD ITEM
        | REMOVE ITEM
        | ADD ITEM COMMA list
        | REMOVE ITEM COMMA list
        ;

%%

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main(void) {
    yyparse();
    return 0;
}
