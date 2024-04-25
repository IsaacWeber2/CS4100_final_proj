%{
#include <iostream>
#include "tree_node.h"
#include "parse_tree.h"

extern int yylex();
extern char* yytext;
extern void yyerror(const char *s) {
    std::cerr << "YACC Error: " << s << " near '" << yytext << "'" << std::endl;
}

%}

%union {
    int num;
    char* str;
}

%token <str> TKNAME TKSTRING
%token <num> TKINT
%token TKBUILD

%type <str> string_expression
%type <num> integer_expression

%left '+' '-'
%left '*' '/'
%right '='

%%
program:
    statement_list
    ;

statement_list:
    | statement_list statement
    ;

statement:
    build_node_statement
    ;

build_node_statement:
    TKBUILD "{" "name" "=" string_expression ";" "weight" "=" integer_expression ";" "isachildof" "=" string_expression ";" "}"
    {
        printf("Build Node: Name=%s, Weight=%d, Parent=%s\n", $5, $9, $13);
    }
    ;

string_expression:
    TKSTRING {
        $$ = strdup($1 + 1);
        $$[strlen($$) - 1] = 0; // Remove quotes at the end of the string
    }
    | TKNAME {
        $$ = strdup($1); // Copy the string value
    }
    ;

integer_expression:
    TKINT {
        $$ = $1; // Directly use the integer value
    }
    | integer_expression '+' integer_expression {
        $$ = $1 + $3; // Calculate the sum of integers
    }
    ;

%%
