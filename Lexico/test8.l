%option noyywrap
%{
#include <stdio.h>
#include<C:\Flex Windows\EditPlusPortable\tokens8.h>

FILE *output;
%}

VERBO_APLICACION "calcular"|"demostrar"|"ejecutar"|"implementar"|"interpretar"|"manipular"|"operar"|"practicar"|"resolver"|"usar"

%%
{VERBO_APLICACION} { fprintf(output, "VERBO_APLICACION: %s\n", yytext); }
. { fputc(yytext[0], output); }

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo_entrada>\n", argv[0]);
        return 1;
    }
    
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error al abrir el archivo de entrada");
        return 1;
    }
    
    output = fopen("test8_output.txt", "w");
    if (!output) {
        perror("Error al abrir el archivo de salida");
        return 1;
    }
    
    fclose(yyin);
    fclose(output);
    return yylex();
}
