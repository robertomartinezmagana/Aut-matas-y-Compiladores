%option noyywrap
%{
	#include <stdio.h>
%}

%%
[A-Z] { printf("%c", yytext[0] + 'a' - 'A'); }
.    { printf("%s", yytext); }
%%

int main() {
    
    return yylex();
}