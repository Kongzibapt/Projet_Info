#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include <string.h>

#define SIZE 1000


struct StackSymbols {
    int top;
    int depth;
    struct Symbol arraySymbols[SIZE];
};

struct StackSymbols stack;

void createStackSymbols(){
    printf("stack created\n");
    stack.top = -1;
    stack.depth = 0;
}

int isEmpty(){
    return stack.top == -1;
}

void pushSymbol(struct Symbol newSymbol){
    newSymbol.address=++stack.top;
    newSymbol.depth = stack.depth;
    printf("top %d\n",stack.top);
    printf("depth %d\n",stack.depth);
    stack.arraySymbols[stack.top]=newSymbol;
    printf("symbol %s pushed to stack \n",newSymbol.id);
}

void incDepth() {
    stack.depth++;
}

void decDepth() {
    stack.depth--;
}

struct Symbol popSymbol(){
    if(isEmpty(stack)){
        printf("Stack is empty.\n");
        exit(EXIT_FAILURE);
    }else{
        return stack.arraySymbols[stack.top--];
    }
}

struct Symbol findTop()
{
    if (isEmpty(stack)){
        printf("stack is empty\n");
        exit(EXIT_FAILURE);
    }
    return stack.arraySymbols[stack.top];
}

void print_stack(){
    printf("ok print\n");
    printf("%d \n",stack.top);
     printf("-----------\n");
    for(int i=0;i<stack.top+1;i++){
        printf("%s | %d | %d | %d \n",stack.arraySymbols[i].id,stack.arraySymbols[i].address,stack.arraySymbols[i].type,stack.arraySymbols[i].depth);
    }
}

int find_symbol(char *name){
    
    for(int i=0;i<stack.top;i++){
        
        if (strcmp(stack.arraySymbols[i].id,name)==0){
            printf("founded symbol\n");
            return 0;
        }
        
    }
    printf("not founded symbol\n");
    return 1;
}
