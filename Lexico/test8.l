%option noyywrap
%{
	#include <stdio.h>
%}

%%
("aplicar"|"demostrar"|"ilustrar"|"interpretar"|"operar"|"practicar"|"utilizar") { printf("Verbo (Aplicación): %s\n", yytext); }
. { }
%%

int main() {

    return yylex();
}