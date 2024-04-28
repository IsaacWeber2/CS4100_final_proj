%{
#include "tree_node.h"
#include "parse_tree.h"
#include <stdio.h>
extern int yylineno;
extern char *yytext;
extern "C" int yylex(void);
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d, text: '%s'\n", s, yylineno, yytext);
}
%}

%union {
    int intValue;
    char* strValue;
}

%token <strValue> STRING_LITERAL IDENTIFIER
%token <intValue> INTEGER
%token EQUALS BUILDNODE ISACHILDOF NAME WEIGHT UNEXPECTED_CHAR

%%

program:
    statements
    ;

statements:
    statement
    | statements statement
    ;

statement:
    buildnode_statement
    ;

buildnode_statement:
    BUILDNODE '{' attrs '}' ';'
    ;

attrs:
    attrs attr
    | attr
    ;

attr:
    name_attr
    | weight_attr
    | isachildof_attr
    ;

name_attr:
    NAME EQUALS STRING_LITERAL ';'
    ;

weight_attr:
    WEIGHT EQUALS INTEGER ';'
    ;

isachildof_attr:
    ISACHILDOF EQUALS STRING_LITERAL ';'
    ;

%%
