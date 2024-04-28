%option noyywrap
%{
#include "y.tab.h"
extern "C" int yylex(void);
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

"buildnode"             { printf("Token: BUILDNODE\n"); return BUILDNODE; }
"name"                  { printf("Token: NAME\n"); return NAME; }
"weight"                { printf("Token: WEIGHT\n"); return WEIGHT; }
"isachildof"            { printf("Token: ISACHILDOF\n"); return ISACHILDOF; }
"="                     { printf("Token: EQUALS\n"); return EQUALS; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.strValue = strdup(yytext); printf("Token: IDENTIFIER (%s)\n", yytext); return IDENTIFIER; }
[0-9]+                  { yylval.intValue = atoi(yytext); printf("Token: INTEGER (%d)\n", yylval.intValue); return INTEGER; }
\"([^"]*)\"             { yylval.strValue = strdup(yytext); printf("Token: STRING_LITERAL (%s)\n", yytext); return STRING_LITERAL; }
[\{\};]                 { printf("Token: '%c'\n", *yytext); return *yytext; }
.                       { printf("Token: UNEXPECTED_CHAR (%c)\n", *yytext); return UNEXPECTED_CHAR; }

%%
