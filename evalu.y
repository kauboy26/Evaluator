%{
	#include <stdio.h>
	#include <math.h>
	#include <ctype.h>
	#include <stdlib.h>
	
	int yylex (void);
	void yyerror (char const *message);
	int *symbol_table;
%}

%define api.value.type {int}
%token NUM IDENTIFIER
%left '+' '-'
%left '*' '/'

%%
input:
  	%empty
| 	input line
;

line:
	'\n'
|  	exp '\n' 					{ printf("%d\n", $1); }
| 	stmt '\n' 					{ printf("%d\n", $1); }
;

stmt:
	IDENTIFIER '=' exp 			{ $$ = symbol_table[($1) % 26] = $3; }
;

exp:
  	NUM 				
| 	IDENTIFIER 			{ $$ = symbol_table[($1) % 26]; }
| 	exp '+' exp 		{ $$ = $1 + $3; 	}
| 	exp '-' exp 		{ $$ = $1 - $3; 	}        		
| 	exp '*' exp			{ $$ = $1 * $3;    	}        		
| 	exp '/' exp			{ 
							if ($3 == 0) printf("Cannot divide by 0.\n");
							else $$ = $1 / $3;
						}
| 	'(' exp ')' 		{ $$ = $2; 			}
;

%%

int main (void) {
	// Set up a primitive hashtable (really just an array that uses a single
	// character as the key).
	symbol_table = calloc(26, sizeof(int));
	if (symbol_table == NULL) {
		return 1;
	}

	int error_code = yyparse();
	free(symbol_table);
	return error_code;
}

int yylex(void) {

	int c = 0;
	// Eat up whitespace
	while ((c = getchar()) == ' ' || c == '\t')
		;

	if (isdigit(c)) {
		// If it's a number, send the whole thing into yylval.
		ungetc(c, stdin);
		scanf("%d", &yylval);
		return NUM;
	}

	if (isalpha(c)) {
		yylval = c;
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