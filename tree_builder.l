%option noyywrap
%{
#include "y.tab.h"
extern "C" int yylex(void);  // Ensure yylex is declared with C linkage
%}

%%

[ \t\n]+                { /* Ignore whitespace */ }

"/*"                    {
    int c;
    while ((c = yyinput()) != 0 && (c != '*' || yyinput() != '/'));
}

"//"                    {
    int c;
    while ((c = yyinput()) != '\n' && c != 0);
}

"buildnode"             { return BUILDNODE; }
"isachildof"            { return ISACHILDOF; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.strValue = strdup(yytext); return IDENTIFIER; }
[0-9]+                  { yylval.intValue = atoi(yytext); return INTEGER; }
\"([^"]*)\"             { yylval.strValue = strdup(yytext); return STRING_LITERAL; }
[\{\};=+]               { return *yytext; }  // Operators and delimiters
.                       { return UNEXPECTED_CHAR; }

%%

