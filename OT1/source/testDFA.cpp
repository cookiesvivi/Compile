#include<iostream>
#include "../include/NFA.h"
#include "../include/DFA.h"
#include "../include/Minimize.h"
using namespace std;
bool isAccepted(DFA dfa, const string& input) {
    int currentState = dfa.start;
    for (char c : input) {
        if (dfa.graph[currentState].find(c) == dfa.graph[currentState].end()) {
            // 不存在转移边，字符串不被接受
            return false; 
        }
        currentState = dfa.graph[currentState][c];
    }
    // 判断最终状态集合中是否包含当前状态
    return dfa.FinalState.count(currentState) > 0; 
}
int main()
{
    //从文件中反序列化出最小DFA
    DFA deserializedDFA = deserializeDFAFromFile("dfa.txt");
    string testString;
    bool IsAccept;
    //循环输入字符串放入DFA中判断
    while(cin>>testString){
      if(testString=="exit")
        break;
      IsAccept=isAccepted(deserializedDFA,testString);
      if(IsAccept){
         cout<<testString<<" : accept!"<<endl;
      }
      else{
         cout<<testString<<" : reject!"<<endl;
      }
    }
}