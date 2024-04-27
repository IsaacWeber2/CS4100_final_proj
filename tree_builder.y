%{
#include "tree_node.h"
#include "parse_tree.h"
#include <stdio.h>
extern "C" int yylex(void);  // Declare yylex with C linkage
void yyerror(const char *s);  // Error handling function
%}

%union {
    int intValue;
    char* strValue;
}

%token <intValue> INTEGER
%token <strValue> STRING_LITERAL IDENTIFIER
%token BUILDNODE ISACHILDOF UNEXPECTED_CHAR

%%

program
    : statements
    ;

statements
    : statement
    | statements statement
    ;

statement
    : buildnode_statement
    | IDENTIFIER
    ;

buildnode_statement
    : BUILDNODE '{' statement_list '}'
    ;

statement_list
    : statement
    | statement_list statement
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
