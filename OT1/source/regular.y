%{
#include<stdlib.h>
#include <stdio.h>
#include<ctype.h>
#include <iostream>
#include "NFA.h"
#include "DFA.h"
#include "Minimize.h"

struct Type{
    char ch;
    struct NFA* nfaNode;
};
#ifndef YYSTYPE
#define YYSTYPE Type
#endif

int main();
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);

%}


%token OR
%token KLEENE 
%token LPAREN 
%token RPAREN
%token<ch> SYMBOL

%left OR        
%right KLEENE   

%type<nfaNode> regex    //正则表达式
%type<nfaNode> catlist  //连接操作
%type<nfaNode> cat      //重复零次或多次的表达式:kleene闭包或者一个primary基本表达式
%type<nfaNode> primary  //基本的表达式:带括号的表达式或一个单一的字符
%start lines            //设置开始符号

%%

lines   :      lines regex ';'              {printNFA($2);
                                             NFA2DFA($2);
                                             hopcroftMinimize(dfa);}
        |      lines ';'                    {exit(0);}
        |      
        ;

regex   :      regex OR catlist             {$$ = newOr($1,$3); delete($1); delete($3);}
        |      catlist                      {$$ = $1;}
        ;

catlist :      catlist cat                  {$$ = newConcat($1,$2); delete($1); delete($2);}
        |      cat                          {$$ = $1;}
        ;

cat     :      cat KLEENE                   {$$ = newClosure($1); delete($1);} 
        |      primary                      {$$ = $1;}
        ;

primary :      LPAREN regex RPAREN          {$$ = $2;} 
        |      SYMBOL                       {$$ = newNFA($1); }
        ;


%%


int yylex()
{
    int t;
    while(1){
        t=getchar();
        if (t==' '||t=='\t'||t=='\n')
        {

        }
        else if (t == '|')
        {
            return OR;
        }
        else if (t == '*')
        {
            return KLEENE;
        }
        else if (t == '(')
        {
            return LPAREN;
        }
        else if (t == ')')
        {
            return RPAREN;
        }
        else if (t == ';')
        {
            return t;
        }
        else{
            yylval.ch = t;
            return SYMBOL;
        }
    }
}
 

int main()
{
    yyin =stdin; 
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