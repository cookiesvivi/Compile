#ifndef DFA_H
#define DFA_H
#include<iostream>
#include<unordered_map>
#include<map>
#include<queue>
#include <stack>
#include <algorithm>
#include "NFA.h"
using namespace std;

static int DfaStateNum=0;

struct DFA
{
   int start;
   map<int, map<char, int>> graph;
   set<int> FinalState;
};

extern DFA* dfa;
void NFA2DFA(NFA* nfa);
set<State*> e_Closure(set<State*>& states);
set<State*> move(set<State*>& states, char ch);
set<State*> ClosureMove(set<State*>& states,char ch);
set<State*>  buildStartState(NFA* nfa);
bool IsFinalState(set<State*>states,int n);
void printDFA(DFA* dfa);

#endif