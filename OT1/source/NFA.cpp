#include"NFA.h"
set<char> alphabet;

void newTransition(State* start,State* end,char ch){
     alphabet.insert(ch);
     start->transitions[ch].push_back(end);
}

NFA* newNFA(char ch){
    alphabet.insert(ch);
    //单个字符：新增一个初态和终态，以及一条边
    State* start = new State(StateNum++); 
    State* end = new State(StateNum++); 
    newTransition(start,end,ch);

    NFA* new_nfa=new NFA(start,end);
    return new_nfa;
}

NFA* newClosure(NFA* nfa){
    State* old_start=nfa->start;
    State* old_end=nfa->end;

    //Kleene闭包：新增一个初态、终态，以及4条ε边
    State* new_start=new State(StateNum++);
    State* new_end=new State(StateNum++);
    newTransition(new_start,old_start,epsilon);
    newTransition(old_end,new_end,epsilon);
    newTransition(old_end,old_start,epsilon);
    newTransition(new_start,new_end,epsilon);

    NFA* new_nfa=new NFA(new_start,new_end);
    return new_nfa;
}

NFA* newConcat(NFA* nfa1,NFA* nfa2){
    if (nfa2 == NULL)
        return nfa1;
    State *mergeStart=nfa1->end;
    State *mergeEnd=nfa2->start;
    //连接：使用课件里的方法一，nfa1的终态与nfa2的初态合并
    mergeStart->transitions=mergeEnd->transitions;

    NFA* new_nfa=new NFA(nfa1->start,nfa2->end);
    return new_nfa;
}

NFA* newOr(NFA* nfa1,NFA* nfa2){

    //选择：新增一个初态、终态，以及4条边
    State* new_start=new State(StateNum++);
    State* new_end=new State(StateNum++);
    newTransition(new_start,nfa1->start,epsilon);
    newTransition(new_start,nfa2->start,epsilon);
    newTransition(nfa1->end,new_end,epsilon);
    newTransition(nfa2->end,new_end,epsilon);

    NFA* new_nfa=new NFA(new_start,new_end);
    return new_nfa;
}

void dfs_print(State* currentState, unordered_set<string>& visitedEdges) {
    visitedEdges.insert(to_string(currentState->id));  // 记录当前状态的ID

    for (const auto& entry : currentState->transitions) {
        char symbol = entry.first;
        for (State* nextState : entry.second) {
            string edgeId = to_string(currentState->id) + " -> " + to_string(nextState->id) + " [label=\"" + symbol + "\"]";

            if (visitedEdges.count(edgeId) == 0) {  // 检查边是否已经访问过
                visitedEdges.insert(edgeId);

                cout <<"\t  " <<edgeId << ";" << endl;
                dfs_print(nextState, visitedEdges);
            }
        }
    }
}

void printNFA(NFA* nfa) {
    cout <<"digraph G{"<<endl;
    cout << "    subgraph cluster_0 {" << endl;
    cout << "      label = \"NFA\";" << endl;
    unordered_set<string> visitedEdges;
    dfs_print(nfa->start, visitedEdges);
    cout << "\t  " << nfa->end->id << " [shape=doublecircle];" << endl;
    cout << "    }" << endl;
    StateNum=0;                                        
}
