%option noyywrap
%{
	#include <stdio.h>
%}

%%
("int"|"float"|"char"|"double"|"void"|"return") { printf("Tipo de dato: %s\n", yytext); }
("if"|"else"|"for"|"while"|"switch"|"case"|"break"|"continue") { printf("Palabra reservada: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Variable: %s\n", yytext); }
. { }
%%

int main() {
    
    return yylex();
}
