%option noyywrap
%{
	#include <stdio.h>
%}

%%
("comparar"|"contrastar"|"diferenciar"|"organizar"|"atribuir"|"examinar") { printf("Verbo (Analizar): %s\n", yytext); }
("bueno"|"excelente"|"maravilloso"|"grandioso"|"notable") { printf("Adjetivo positivo: %s\n", yytext); }
("y"|"pero"|"aunque"|"o"|"porque") { printf("Conjunción: %s\n", yytext); }
("en"|"sobre"|"entre"|"hacia"|"desde") { printf("Preposición: %s\n", yytext); }
("yo"|"tú"|"él"|"nosotros"|"ellos") { printf("Pronombre: %s\n", yytext); }
. { }
%%

int main() {
    
    return yylex();
}