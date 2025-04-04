%option noyywrap
%{
#include <stdio.h>
#include<C:\Flex Windows\EditPlusPortable\tokens7.h>

FILE *output;
%}

%%
. { fputc(tolower(yytext[0]), output); }

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
    
    output = fopen("test7_output.txt", "w");
    if (!output) {
        perror("Error al abrir el archivo de salida");
        return 1;
    }
    
    fclose(yyin);
    fclose(output);
    return yylex();
}
