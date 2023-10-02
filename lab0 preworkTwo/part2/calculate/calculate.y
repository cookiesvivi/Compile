%{
#include <stdio.h>
#include <stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}

%token ADD
%token MINUS
%token MUL
%token DIV
%token UMINUS
%token LEFT_PAREN
%token RIGHT_PAREN
%token NUMBER

%left ADD MINUS
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';' {printf("%f\n", $2);}
        |   lines ';'
        |   
        ;

expr    :   expr ADD expr               {$$ = $1 + $3;}
        |   expr MINUS expr             {$$ = $1 - $3;}
        |   expr MUL expr               {$$ = $1 * $3;}
        |   expr DIV expr               {$$ = $1 / $3;}
        |   LEFT_PAREN expr RIGHT_PAREN {$$ = $2;}
        |   MINUS expr %prec UMINUS     {$$ = -$2;}
        |   NUMBER                      {$$ = $1;}
        ;

%%

int yylex()
{
    int t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t =='\n');
        else if (isdigit(t))
        {
            yylval = 0;
            while(isdigit(t))
            {
                yylval = yylval * 10 + t - '0';
                t = getchar();
            }
            ungetc(t, stdin);
            return NUMBER;
        }
        else if (t == '+')
        {
            return ADD;
        }
        else if(t == '-')
        {
            return MINUS;
        }
        else if (t == '*')
        {
            return MUL;
        }
        else if (t == '/')
        {
            return DIV;
        }
        else if (t == '(')
        {
            return LEFT_PAREN;
        }
        else if (t == ')')
        {
            return RIGHT_PAREN;
        }
        else
        {
            return t;
        }
    }
}

int main()
{
    yyin = stdin;
    do {
        yyparse();
    } while(!feof(yyin));
    return 0;
}

void yyerror(const char* s)
{
    fprintf(stderr, "Parse error:%s\n", s);
    exit(1);
}