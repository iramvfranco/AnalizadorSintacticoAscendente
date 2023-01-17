%{
#include "y.tab.h"
%}

%%
"add"    { return ADD; }
"remove" { return REMOVE; }
","      { return COMMA; }
[a-zA-Z]+ { yylval = yytext; return ITEM; }

%%
