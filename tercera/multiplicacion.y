%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUMBER
%token MULT

%%
input:
    expr { printf("Expresion valida\n"); return 0; }
  ;

expr:
    NUMBER MULT NUMBER
  ;

%%

int main() {
    printf("Ingrese la expresion:");
    return yyparse();
}

int yyerror(char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
    return 1;
}
