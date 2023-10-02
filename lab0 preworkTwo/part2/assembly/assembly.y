%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <iostream>
using namespace std;
#include <string>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif

char num_str[50];
char id_str[50];
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
int temp_var_count = 0;
char* new_temp_var() {
    char* temp = (char*)malloc(50*sizeof(char));
    sprintf(temp, "temp%d", temp_var_count++);
    return temp;
}

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

lines   :   lines expr ';'              {printf("Result in: %s\n", $2);
                                        printf("---------------------------\n");}
        |   lines ';'
        |   
        ;

expr    :   expr ADD expr               {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        printf("ADD %s, %s\n", temp, $3);
                                        $$ = temp;
                                        }
        |   expr MINUS expr             {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        printf("SUB %s, %s\n", temp, $3);
                                        $$ = temp;
                                        }
        |   expr MUL expr               {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        printf("MUL %s, %s\n", temp, $3);
                                        $$ = temp;
                                        }
        |   expr DIV expr               {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        printf("DIV %s, %s\n", temp, $3);
                                        $$ = temp;
                                        }
        |   LEFT_PAREN expr RIGHT_PAREN {$$ = $2;}
        |   MINUS expr %prec UMINUS     {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $2);
                                        printf("NEG %s\n", temp);
                                        $$ = temp;
                                        }
        |   NUMBER                      {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        $$ = temp;
                                        }
        |   ID                          {
                                        char* temp = new_temp_var();
                                        printf("MOV %s, %s\n", temp, $1);
                                        $$ = temp;
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