#include "DFA.h"

DFA* dfa=new DFA();
unordered_map<int, set<State*>> dfaStateMap;

set<State*> e_Closure(set<State*>& states){
    set<State*> closure = states;
    stack<State*> stateStack;  

    for (State* s : states) {
        stateStack.push(s);
    }

    while (!stateStack.empty()) {  
        State* s = stateStack.top(); 
        stateStack.pop();  

        for (State* t : s->transitions[epsilon]) {
            if (closure.find(t) == closure.end()) {
                closure.insert(t);
                stateStack.push(t);  
            }
        }
    }

    return closure;
}

set<State*> move(set<State*>& states, char ch) {
    set<State*> result;

    for (State* s : states) {
        for (State* t : s->transitions[ch]) {
            result.insert(t);
        }
    }

    return result;
}

set<State*> ClosureMove(set<State*>& states,char ch) {
    set<State*> result;
    result=move(states,ch);
    return e_Closure(result);
}

bool IsFinalState(set<State*>states,int n){
    for (State* s : states) {
        if (s->id == n) {
            return true;
        }
    }
    return false;
}

set<State*>  buildStartState(NFA* nfa){
    alphabet.erase('#');
    DfaStateNum=0;
    set<State*> nfastart;
    nfastart.insert(nfa->start);
    set<State*> startState;
    startState=e_Closure(nfastart);
    if(IsFinalState(startState,nfa->end->id))
      (dfa->FinalState).insert(0);
    DfaStateNum++;
    return startState;
}

void printDFA(DFA* dfa)
{
    cout << "    subgraph cluster_1 {" << endl;
    cout << "      label = \"DFA\";" << endl;
    for (auto state : dfa->graph) {
        for (auto edge : state.second) {
            cout << "\t  ." << state.first << " -> ." << edge.second << " [label=\"" << edge.first << "\"];" << endl;
        }
    }
    for (auto state : dfa->FinalState) {
        cout << "\t  ." << state << " [shape=doublecircle];" << endl;
    }
    cout << "    }" << endl;

}

void NFA2DFA(NFA* nfa){

    dfa->start = 0;
    dfa->graph.clear();
    dfa->FinalState.clear();
    dfaStateMap.clear();

    set<State*> startState=buildStartState(nfa);
    vector<set<State*>> dfaStates={startState};
    dfaStateMap={{0, startState}};
    dfa->start=0;

    queue<int> stateQueue; 
    stateQueue.push(0); 

    while (!stateQueue.empty()) {
        int currentStateIdx = stateQueue.front(); 
        stateQueue.pop(); 

        set<State*> currentState = dfaStateMap[currentStateIdx];
        map<char,int> trans;

        for (char c : alphabet) {
            set<State*> nextState = ClosureMove(currentState, c);
            if(!nextState.empty()){
                if (find(dfaStates.begin(), dfaStates.end(), nextState) == dfaStates.end()) {
                dfaStates.push_back(nextState);
                dfaStateMap[DfaStateNum] = nextState;
                trans[c]=DfaStateNum;
                stateQueue.push(DfaStateNum);
                if(IsFinalState(nextState,nfa->end->id))
                   (dfa->FinalState).insert(DfaStateNum);
                DfaStateNum++;
                }
                else{
                    trans[c]= distance(dfaStates.begin(), find(dfaStates.begin(), dfaStates.end(), nextState));
                }
            }
            dfa->graph[currentStateIdx]=trans;
        }
    }
    printDFA(dfa);
}

