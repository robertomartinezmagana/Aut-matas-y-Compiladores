%{
#include <stdio.h>
#include <string.h>
#include "struct.h"
int yylex();
int yyerror();
symbtbl *ptr;
%}

%union
{
struct {
    int numerorighe;
    symbtbl *Mystr;
};
};

%token <numerorighe> NL
%token <Mystr> IDENTIFIER CONST '<' '>' '=' '*'
%token SELECT FROM WHERE AND OR DELETE INSERT
%type <Mystr> identifiers cond compare

%%

lines:
      line
    | lines line
    | lines error
    ;

line:
      select identifiers FROM identifiers WHERE cond NL {
          ptr = putsymb($2, $4, $7);
      }
    | delete FROM identifiers WHERE cond NL {
          /* Código para DELETE */
      }
    | insert identifiers NL {
          /* Código para INSERT */
      }
    ;

identifiers:
      '*' { $$ = "ALL"; }
    | IDENTIFIER { $$ = $1; }
    | IDENTIFIER ',' identifiers {
          char* s = malloc(sizeof(char) * (strlen($1) + strlen($3) + 2));
          strcpy(s, $1);
          strcat(s, " ");
          strcat(s, $3);
          $$ = s;
      }
    ;

select:
      SELECT
    ;

delete:
      DELETE
    ;

insert:
      INSERT
    ;

cond:
      IDENTIFIER op compare
    | IDENTIFIER op compare conn cond
    ;

compare:
      IDENTIFIER
    | CONST
    ;

op:
      '<'
    | '='
    | '>'
    ;

conn:
      AND
    | OR
    ;

%%

int yyerror(char *s) {
    printf("  --ERROR--  %s\n\n", s);
    return *s;
}

int main() {
    FILE* del;
    char filename[] = "results.txt";
    del = fopen(filename, "a");
    remove(filename);
    yyparse();
    return 0;
}