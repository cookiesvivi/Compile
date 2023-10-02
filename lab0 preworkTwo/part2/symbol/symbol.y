%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string>
#include <cfloat>
#include <unordered_map>
#include <iostream>
using namespace std;

struct Type {
    string m_id;
    double m_num;
};
#ifndef YYSTYPE
#define YYSTYPE Type
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);

//符号表
class SymbolTable {
    unordered_map<string, double> symbolTable;
public:
    bool find(string idstr);
    void insert(string idstr, double value);
    double get(string idstr);
    void print();
};

SymbolTable symbolTable;
%}

%token ADD
%token MINUS
%token MUL
%token DIV
%token UMINUS
%token LEFT_PAREN
%token RIGHT_PAREN
%token<m_num> NUMBER
%token<m_id> ID

%type<m_num> expr

%left ADD MINUS
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';'              {symbolTable.print();
                                        printf("Calculate result:\n");
                                        printf("%f\n",$2 );}

        |   lines assign ';'          
        |   lines ';'
        |   
        ;

assign  :   ID '=' expr                {symbolTable.insert($1, $3);}
        ;

expr    :   expr ADD expr               {$$ = $1+ $3;}
        |   expr MINUS expr             {$$ = $1 - $3;}
        |   expr MUL expr               {$$ = $1 * $3;}
        |   expr DIV expr               {$$ = $1 / $3;}
        |   LEFT_PAREN expr RIGHT_PAREN {$$ = $2;}
        |   MINUS expr %prec UMINUS     {$$ = -$2;}
        |   NUMBER                      {$$ = $1;}
        |   ID                          {
                                        string id = $1;
                                        $$ = symbolTable.get(id);
                                        }
        ;

%%

int yylex()
{
    char t;
    while(1) {
        t = getchar();
        if(t == ' ' || t == '\t' || t =='\n');
        else if (isdigit(t)){
            double num = 0;
            while(isdigit(t)){
                num = num * 10 + t - '0';
                t = getchar();
            }
            yylval.m_num = num;
            ungetc(t, stdin);
            return NUMBER;
        }
        else if (isalpha(t) || t == '_'){
            string str = "";
            while(isalpha(t) || isdigit(t) || t == '_'){
                str.push_back(t);
                t = getchar();
            }
            ungetc(t, stdin);
            if(!symbolTable.find(str)){
                 symbolTable.insert(str, 0);
                }
                yylval.m_id = str;
                return ID;
            
        }
        else if (t == '+'){
            return ADD;
        }
        else if(t == '-'){
            return MINUS;
        }
        else if (t == '*'){
            return MUL;
        }
        else if (t == '/'){
            return DIV;
        }
        else if (t == '('){
            return LEFT_PAREN;
        }
        else if (t == ')'){
            return RIGHT_PAREN;
        }
        else{
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
bool SymbolTable::find(string idstr)
{
    return symbolTable.count(idstr) > 0;
}
void SymbolTable::insert(string idstr, double value)
{
    auto res = symbolTable.insert(pair<string, double>(idstr, value));
    if(!res.second){ 
        symbolTable[idstr] = value;
    }
    //print();
}

double SymbolTable::get(string idstr)
{
    return symbolTable.find(idstr)->second;
}

void SymbolTable::print()
{
    cout << "Current SymbolTable:-------------------------------" << endl;
    for (const auto& [key, value] : symbolTable)
    {
        cout << key << " = " << value << endl;
    }
}