%{/*Seccion Declaraciones*/
    #include <stdio.h>
    void yyerror(char *msg); /*Manejo de errores en Yacc es necesario que 
                                el usuario la proporcione*/
    int yylex(void); /*Necesario para hacer referencia a Lex*/
    extern FILE *yyin; /*Apuntador a Fichero*/
    extern int yylineno; /*Para poder leer las lineas heredadas de Lex*/
%}
%union { /*Union necesario para poder recibir las cadenas de lex*/
    float numero; /*recibe los reales*/
    char identificador[100]; /*recibe cadenas de caracteres*/
};

%token <numero> REAL/*token para real recibido de Lex*/
%token <identificador> ID/*token para identificador recibido de Lex*/
%token OPE /*token para operadores recibido de Lex*/
%token PARIZQ /*token para parentesis que abre recibido de Lex*/
%token PARDER /*token para parentesis que cierra recibido de Lex*/
%token CRLF /*token para salto de linea recibido de Lex*/

%start INICIO/*inicio de la gramatica*/
/*Seccion de reglas*/
%% 
INICIO: GRAM GRAM | GRAM    {/*Inicio de la gramticas
                                Llama a gramatica para ver si avanza o no*/};
GRAM:   E CRLF              {printf("Cadena Aceptada\n"); 
                                /*Si la cadena la reconoce la gramatica y hay salto 
                                de linea la cadena es aceptada y realiza un salto de linea*/ }
        | error CRLF        {yyerrok; 
                                /*Si hay un error la gramatica no la reconece y avanza*/}; 
E:      T
        | E OPE T;
T:      ID
        | REAL
        | PARIZQ E PARDER;

%%
void yyerror(char *msg){
    /*imprime el error e imprime la linea en donde se encuentra*/
    printf("\tError Sintactico en linea %d\n",yylineno); 
}
/*void main(){
    yyparse();
}*/
void main(int argc, char *argv[]){
    /*Abre el archivo*/
    if (argc >1)
        yyin=fopen(argv[1],"rt");
    else 
        printf("ERROR\n");
    /*Llama a parse que realiza la gramatica*/
    yyparse();
    fclose(yyin);
}
 