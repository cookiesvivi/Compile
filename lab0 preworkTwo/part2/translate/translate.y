%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif

char num_str[50];
char id_str[50];
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
%token ID

%left ADD MINUS
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';'              {printf("%s\n", $2);}
        |   lines ';'
        |   
        ;

expr    :   expr ADD expr               {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, $3);
                                        strcat($$, "+ ");
                                        }
        |   expr MINUS expr             {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, $3);
                                        strcat($$, "- ");
                                        }
        |   expr MUL expr               {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, $3);
                                        strcat($$, "* ");
                                        }
        |   expr DIV expr               {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, $3);
                                        strcat($$, "/ ");
                                        }
        |   LEFT_PAREN expr RIGHT_PAREN {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $2);
                                        strcat($$, " ");
                                        }
        |   MINUS expr %prec UMINUS     {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcat($$, $2);
                                        strcat($$, "-");
                                        }
        |   NUMBER                      {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, " ");
                                        }
        |   ID                          {
                                        $$ = (char*) malloc (50*sizeof(char));
                                        strcpy($$, $1);
                                        strcat($$, " ");
                                        }
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
            int index = 0;
            while(isdigit(t))
            {
                num_str[index] = t;
                t = getchar();
                index++;
            }
            num_str[index] = '\0';
            yylval = num_str;
            ungetc(t, stdin);
            return NUMBER;
        }
        else if (isalpha(t) || t == '_')
        {
            int index = 0;
            while(isalpha(t) || isdigit(t) || t == '_')
            {
                id_str[index] = t;
                t = getchar();
                index++;
            }
            id_str[index] = '\0';
            yylval = id_str;
            ungetc(t, stdin);
            return ID;
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