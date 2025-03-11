%option noyywrap
%{
#include <stdio.h>
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.edu\.mx { printf("Email institucional: %s\n", yytext); }
[\t\n ]+ ;
. { printf("Carácter no reconocido: %s\n", yytext); }
%%

int main() {
    return yylex();
}
