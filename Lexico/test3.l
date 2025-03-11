%option noyywrap
%{
#include <stdio.h>
%}

%%
[a-zA-Z][a-zA-Z0-9_]* { printf("Identificador: %s\n", yytext); }
[\t\n ]+ ;
. { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main() {
    return yylex();
}
