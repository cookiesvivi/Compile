#include"Minimize.h"
DFA* minimizedDFA=new DFA();

void serializeDFAToFile(const DFA& dfa, const std::string& filename) {
    std::ofstream outFile(filename);

    // 写入start状态
    outFile << dfa.start << "\n";
    // 写入FinalState
    for (int state : dfa.FinalState) {
        outFile << state << " ";
            }
    outFile << "\n";
    // 写入graph
    for (const auto& entry : dfa.graph) {
        int fromState = entry.first;
        for (const auto& transition : entry.second) {
            char input = transition.first;
            int toState = transition.second;
            outFile << input  << " " << fromState<< " " << toState << "\n";
        }
    }

    outFile.close();
}

DFA deserializeDFAFromFile(const std::string& filename) {
    DFA dfa;

    std::ifstream inFile(filename);
    if (!inFile.is_open()) {
        std::cerr << "Error: Unable to open file: " << filename << std::endl;
        return dfa;
    }

    // 读取start状态
    inFile >> dfa.start;
    // 读取FinalState
    int state;
    while (inFile >> state) {
        dfa.FinalState.insert(state);
    }
    inFile.clear(); 
    // 读取graph
    int fromState, toState;
    char input;
    while (inFile >> input >> fromState >> toState) {
        dfa.graph[fromState][input] = toState;
    }

    inFile.close();
    return dfa;
}


void printMiniDFA(DFA* dfa)
{
    cout << "    subgraph cluster_2 {" << endl;
    cout << "      label = \"MinimalDFA\";" << endl;
    for (auto state : dfa->graph) {
        for (auto edge : state.second) {
            cout << "\t  " << state.first << ". -> " << edge.second << ". [label=\"" << edge.first << "\"];" << endl;
        }
    }
    for (auto state : dfa->FinalState) {
        cout << "\t  " << state << ". [shape=doublecircle];" << endl;
    }
    cout << "    }" << endl;
    cout << "}" << endl<<endl;
}

void hopcroftMinimize(DFA* dfa){

    minimizedDFA->start = 0;
    minimizedDFA->graph.clear();
    minimizedDFA->FinalState.clear();

    //classes:等价类集合
    //初始里面只有非终态和终态
    vector<set<int>> classes;
    set<int> nonFinalStates, FinalStates;
    for (int i = 0; i < dfa->graph.size(); i++){
        if (dfa->FinalState.count(i) > 0){
            FinalStates.insert(i);
        }
        else{
            nonFinalStates.insert(i);
        }
    }
    if (!nonFinalStates.empty()) {
        classes.push_back(nonFinalStates);
    }
    if (!FinalStates.empty()) {
        classes.push_back(FinalStates);
    }

    //workList:所有字符与所有等价类id的键值对
    queue<pair<char, int>> workList;
    for (char c : alphabet){
        for (int i = 0; i < classes.size(); i++){
            workList.push(make_pair(c, i));
        }
    }

    //循环结束的条件是某一轮迭代等价类数不变
    //一轮迭代是指：所有字符与所有等价类
    while (!workList.empty()){
        char c = workList.front().first;
        int classIdx = workList.front().second;
        workList.pop();

        //newClasses:导向的类的id<->导向该类的state的id集合
        map<int, set<int>> newClasses;  

        for (int state : classes[classIdx]) {
            int nextState;
            auto it = dfa->graph[state].find(c);
            if (it != dfa->graph[state].end()) {
                nextState = it->second;
            } else {
                nextState = -1;
            }
            if(nextState==-1){
                newClasses[classIdx].insert(state);
            }
            else{
                 //找这个nextState是属于哪个等价类的
                for (int j = 0; j < classes.size(); j++) {
                    //键是等价类的id,值是当前状态的集合
                    if (classes[j].count(nextState) > 0) {
                        newClasses[j].insert(state);
                        break;
                    }
                }
            }
        }
        //如果大于1则说明导向了不同的等价类
        if (newClasses.size() > 1){
            //删去待拆分的等价类
            classes.erase(classes.begin() + classIdx);
            //把新的等价类加入
            for(auto& entry : newClasses) {
            classes.push_back(entry.second);
            }
            //清空工作区
            queue<pair<char, int>>().swap(workList);
            //重置工作区
            for (char c : alphabet){
                for (int i = 0; i < classes.size(); i++){
                    workList.push(make_pair(c, i));
                }
            }
        }
    }

    MinimizedDFA(dfa,classes);
    printMiniDFA(minimizedDFA);
    // 将DFA序列化到文件
    serializeDFAToFile(*minimizedDFA, "dfa.txt");

}

void MinimizedDFA(DFA* dfa,vector<set<int>> classes) {

    set<int> zeroClass;
    for (int i = 0; i < classes.size(); i++) {
        if (classes[i].count(dfa->start) > 0) {
            zeroClass = classes[i];
            classes.erase(classes.begin() + i);
            break;
        }
    }
    classes.insert(classes.begin(), zeroClass);
    minimizedDFA->start=0;

    // 遍历新的等价类以构建最小化DFA的图和终态集合
    for (int i = 0; i < classes.size(); i++) {

        //从集合中获取任意一个状态作为代表
        set<int> currentStateSet = classes[i];
        int representativeState = *currentStateSet.begin(); 

        for (auto& transition : dfa->graph[representativeState]) {
            char symbol = transition.first;
            int nextState = transition.second;
            int nextClassIdx = -1;

            //找到包含下一个状态的等价类
            for (int j = 0; j < classes.size(); j++) {
                if (classes[j].count(nextState) > 0) {
                    nextClassIdx = j;
                    break;
                }
            }
            //将转移加入最小化DFA
            minimizedDFA->graph[i][symbol] = nextClassIdx;
        }

        // 如果代表状态是终态，将其加入到最小化DFA的终态集合中
        if (dfa->FinalState.count(representativeState) > 0) {
            minimizedDFA->FinalState.insert(i);
        }
    }
}
