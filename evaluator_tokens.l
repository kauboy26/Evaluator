%{
	#include <stdlib.h>
	void yyerror( char *);
	#include "y.tab.h"
%}

%%
[0-9]+ 		{
				yylval = atoi(yytext);
				return INTEGER;
				// printf("Found a number");
			}
[-+] 		{
				return *yytext;
				// printf("Found operator");
			}
[\ \t]+ 		{ ; /* Eat whitespace */}
. 			{
				yyerror("What the heck is this!");
				// printf("Unknown expression. %d\n", yylineno);
			}
\n
%%

int yywrap(void) {
	return 1;
}