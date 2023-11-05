SRC_PATH ?= source
INC_PATH += include
BUILD_PATH ?= build
BINARY_1 = $(BUILD_PATH)/MinimalDFA
BINARY_2 = $(BUILD_PATH)/test_MinimalDFA

INC = $(addprefix -I, $(INC_PATH))
SRC = $(shell find $(SRC_PATH) -name "*.cpp")
CFLAGS = -O0 -w $(INC)
YYAC = $(SRC_PATH)/regular.y
YYACER = $(addsuffix .cpp, $(basename $(YYAC)))

.PHONY: all app_buildDFA app_testDFA buildDFA testDFA clean

all: app_buildDFA app_testDFA

$(YYACER):$(YYAC)
	yacc -o $@ $<

$(BINARY_1): $(filter-out $(SRC_PATH)/testDFA.cpp, $(SRC))
	g++ $(CFLAGS) -o $@ $^

$(BINARY_2): $(filter-out $(SRC_PATH)/regular.cpp, $(SRC))
	g++ $(CFLAGS) -o $@ $^

app_buildDFA: $(YYACER) $(BINARY_1)

app_testDFA: $(BINARY_2)

buildDFA: app_buildDFA
	$(BINARY_1) < input.txt > output.dot

testDFA: app_testDFA
	$(BINARY_2) 

clean:
	rm -rf $(BUILD_PATH)
