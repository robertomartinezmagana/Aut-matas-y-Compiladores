%option noyywrap
%{
#include <stdio.h>
#include<C:\Flex Windows\EditPlusPortable\tokens9.h>

FILE *output;
%}

VERBO_ANALIZAR "comparar"|"contrastar"|"diferenciar"|"examinar"|"inspeccionar"|"relacionar"
ADJETIVO_POSITIVO "excelente"|"magnífico"|"brillante"|"fantástico"|"notable"
CONJUNCION "y"|"o"|"pero"|"aunque"
PREPOSICION "en"|"con"|"por"|"para"|"sobre"
PRONOMBRE "él"|"ella"|"ellos"|"nosotros"|"tú"

%%
{VERBO_ANALIZAR} { fprintf(output, "VERBO_ANALIZAR: %s\n", yytext); }
{ADJETIVO_POSITIVO} { fprintf(output, "ADJETIVO_POSITIVO: %s\n", yytext); }
{CONJUNCION} { fprintf(output, "CONJUNCION: %s\n", yytext); }
{PREPOSICION} { fprintf(output, "PREPOSICION: %s\n", yytext); }
{PRONOMBRE} { fprintf(output, "PRONOMBRE: %s\n", yytext); }
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
    
    output = fopen("test9_output.txt", "w");
    if (!output) {
        perror("Error al abrir el archivo de salida");
        return 1;
    }
    
    fclose(yyin);
    fclose(output);
    return yylex();
}