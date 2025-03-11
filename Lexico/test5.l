%option noyywrap
%{
#include <stdio.h>
%}

%%
[A-Z]{1}[AEIOU]{1}[A-Z]{2}[0-9]{6}[HM]{1}[A-Z]{2}[B-DF-HJ-NP-TV-Z]{3}[0-9A-Z]{1}[0-9]{1} { printf("CURP: %s\n", yytext); }
[\t\n ]+ ;
. { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main() {
    return yylex();
}
