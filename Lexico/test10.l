%option noyywrap
%{
#include <stdio.h>
#include<C:\Flex Windows\EditPlusPortable\tokens10.h>

FILE *output;
%}

PALABRA_RESERVADA "int"|"float"|"char"|"if"|"else"|"while"|"for"|"return"|"void"|"switch"
TIPO_DATO "int"|"float"|"double"|"char"|"void"
VARIABLE [_a-zA-Z][_a-zA-Z0-9]*

%%
{PALABRA_RESERVADA} { fprintf(output, "PALABRA_RESERVADA: %s\n", yytext); }
{TIPO_DATO} { fprintf(output, "TIPO_DATO: %s\n", yytext); }
{VARIABLE} { fprintf(output, "VARIABLE: %s\n", yytext); }
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
    
    output = fopen("test10_output.txt", "w");
    if (!output) {
        perror("Error al abrir el archivo de salida");
        return 1;
    }
    
    fclose(yyin);
    fclose(output);
    return yylex();
}

