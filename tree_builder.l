%{
#include "y.tab.h"
#include <stdio.h>
%}

%option noyywrap

%%

"buildnode"                { return TKBUILD; }
";"                        { return ';'; }
"{"                        { return '{'; }
"}"                        { return '}'; }
"="                        { return '='; }
"+"                        { return '+'; }
","                        { return ','; }
[a-zA-Z_][a-zA-Z0-9_]*     { yylval.str = strdup(yytext); return TKNAME; }
[0-9]+                     { yylval.num = atoi(yytext); return TKINT; }
\"[^"]*\"                  { yylval.str = strdup(yytext + 1); yylval.str[strlen(yylval.str) - 1] = 0; return TKSTRING; }
[ \t\r\n]+                 { /* ignore whitespace */ }
.                          { return yytext[0]; }  /* catch all single chars */

%%
