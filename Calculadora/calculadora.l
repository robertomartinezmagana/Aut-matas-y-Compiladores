/* SECCION DE DECLARACIONES*/
%{
	#include<stdio.h>
	#include "calculator.tab.h"
	extern YYSTYPE yylval;
	int yyerror(char *s);
%}

/*SECCION DE REGLAS*/
%%
[0-9]+       { yylval.num = atoi(yytext); return NUMBER; }
"+"          { return PLUS; }
"-"          { return MINUS; }
"*"          { return MULT; }
"/"          { return DIV; }
"\n"         { return EOL; }
[ \t\f\v]    {}
.            { return *yytext; }
%%

int yywrap(void) {
	return 1;
}
