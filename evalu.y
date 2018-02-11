%{
	#include <stdio.h>
	#include <math.h>
	#include <ctype.h>
	
	int yylex (void);
	void yyerror (char const *message);	
%}

%define api.value.type {double}
%token NUM
%left '*' '+'

%%
input:
  	%empty
| 	input line
;

line:
  	'\n'
| 	exp '\n'     		{ 
							printf("%0.10g\n", $1);
							// printf ("$$: %.10g  $1: %0.10g $2: %0.10g\n", $$, $1, $2);
						}
;

exp:
  	NUM
| 	exp '+' exp 		{ $$ = $1 + $3; 	}        		
| 	exp '*' exp			{ $$ = $1 * $3;    	}

%%

int main (void) {

	return yyparse();
}

int yylex(void) {

	int c = 0;
	// Eat up whitespace
	while ((c = getchar()) == ' ' || c == '\t')
		;

	if (c == '.' || isdigit(c)) {
		// If it's a number, send the whole thing into yylval
		ungetc(c, stdin);
		scanf("%lf", &yylval);
		return NUM;
	}

	if (isalpha(c)) {
		// Put the thing into 
		return IDENTIFIER;
	}

	if (c == EOF) {
		return 0;
	}
	return c; // This happens when c is '+', etc.
}

void yyerror (char const *s)
{
  	fprintf (stderr, "%s\n", s);
}