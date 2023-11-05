#ifndef NFA_H
#define NFA_H

#include<iostream>
#include<unordered_map>
#include<unordered_set>
#include<vector>
#include <set>
#include <fstream>
using namespace std;

static int StateNum=0;
const char epsilon = '#';
extern set<char> alphabet;

struct State{
    int id;
    //状态转移(动作+边）：不同字符导向不同状态 or 相同字符导向不同状态
    unordered_map<char, vector<State*>> transitions;
    State(int state_id) : id(state_id) {};
};

struct NFA{
    State* start;
    State* end;
    NFA(struct State* s, struct State* e) : start(s), end(e) {};
};

NFA* newNFA(char ch);
void newTransition(State* start,State* end,char ch);
NFA* newClosure(NFA* nfa);
NFA* newConcat(NFA* nfa1,NFA* nfa2);
NFA* newOr(NFA* nfa1,NFA* nfa2);
void dfs_print(State* currentState, unordered_set<string>& visitedEdges);
void printNFA(NFA* nfa);

#endif