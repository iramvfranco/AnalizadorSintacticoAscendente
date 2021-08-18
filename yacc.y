%{
    #include <stdio.h>
    void yyerror(char *msg);
    int yylex(void);
    extern FILE *yyin;
    extern int yylineno;
%}
%union {
    float numero;    
    char identificador[100]; 
};

%token <numero> REAL
%token <identificador> ID
%token OPE
%token PARIZQ
%token PARDER
%token CRLF

%start INICIO

%% 
INICIO: GRAM GRAM |GRAM ;
GRAM:   E CRLF {printf("Cadena Aceptada\n");}
        | error CRLF {yyerrok;}; 
E:      T
        | T OPE T;
T:      ID
        | REAL
        | PARIZQ E PARDER;

%%
void yyerror(char *msg){
    printf("\tError Sintactico en linea %d\n",yylineno);
}
/*void main(){
    yyparse();
}*/
void main(int argc, char *argv[]){
    if (argc >1)
        yyin=fopen(argv[1],"rt");
    else 
        printf("ERROR\n");
    yyparse();
    fclose(yyin);
}
