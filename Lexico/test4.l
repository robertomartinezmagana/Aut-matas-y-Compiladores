%option noyywrap
%{
#include <stdio.h>
%}

%%
[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}? { printf("RFC: %s\n", yytext); }
[\t\n ]+ ;
. { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main() {
    return yylex();
}
