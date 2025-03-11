%option noyywrap
%{
#include <stdio.h>
%}

%%
[0-9]+ { printf("Numero entero: %s\n", yytext); }
[\t\n ]+ ;
. { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main() {
    return yylex();
}
