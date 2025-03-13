%option noyywrap
%{
	#include <stdio.h>
%}

%%

"/*"([^*]|"*"+[^*/])*"*"+"/"   { printf("Comentario multilinea encontrado: %s\n", yytext); }

"//".*                        { printf("Comentario de una linea encontrado: %s\n", yytext); }

\"(\\.|[^"\\])*\"              { printf("Cadena de texto encontrada: %s\n", yytext); }

[ \t\n]+                       ; // Ignorar espacios en blanco, tabulaciones y saltos de línea

.                              { printf("Caracter no reconocido: %s\n", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error al abrir el archivo");
            return 1;
        }
        yyin = file;
    }

    yylex(); // Llama al analizador léxico

    if (argc > 1) {
        fclose(yyin);
    }

    return 0;
}

int yywrap() {
    return yylex();
}