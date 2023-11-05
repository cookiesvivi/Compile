#ifndef MINIMIZE_H
#define MINIMIZE_H

#include "DFA.h"
#include "NFA.h"
#include<iostream>
#include<fstream>
#include<sstream>
#include<unordered_map>
#include<map>
#include<queue>
#include <stack>
#include <algorithm>
using namespace std;

extern DFA* minimizedDFA;
void printMiniDFA(DFA* dfa);
void hopcroftMinimize(DFA* dfa);
void MinimizedDFA(DFA* dfa,vector<set<int>> classes);
void serializeDFAToFile(const DFA& dfa, const std::string& filename);
DFA deserializeDFAFromFile(const std::string& filename);



#endif