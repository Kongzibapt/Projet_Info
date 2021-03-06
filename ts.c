#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include <string.h>

#define SIZE 1000


struct StackSymbols {
    int top;
    int depth;
    int end;
    struct Symbol arraySymbols[SIZE];
};

struct StackSymbols stack;

void createStackSymbols(){
    printf("stack created\n");
    stack.top = -1;
    stack.depth = 0;
    stack.end = SIZE;
}

int isEmpty(){
    return stack.top == -1;
}

int pushSymbol(struct Symbol newSymbol){
    if(newSymbol.type==2){
        newSymbol.address=--stack.end;
        printf("end %d\n",stack.end);
        printf("depth %d\n",newSymbol.depth);
        stack.arraySymbols[stack.end]=newSymbol;
        printf("symbol temp %s pushed to stack \n",newSymbol.id);
    }else{
        newSymbol.address=++stack.top;
        printf("top %d\n",stack.top);
        printf("depth %d\n",newSymbol.depth);
        stack.arraySymbols[stack.top]=newSymbol;
        printf("symbol %s pushed to stack \n",newSymbol.id);
    }
    return newSymbol.address;
}

int newIntTmp() {
        struct Symbol newSymbol;
        newSymbol.id = "";
        newSymbol.type = 2;
        newSymbol.depth = stack.depth;
        return pushSymbol(newSymbol);
}

int newInt(char *nom) {
        struct Symbol newSymbol;
        newSymbol.id = nom;
        newSymbol.type = 1;
        newSymbol.depth = stack.depth;
        return pushSymbol(newSymbol);
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
        for(int i=0;i<stack.top+1;i++){
            if(stack.arraySymbols[stack.top].depth==stack.depth){
                stack.top--;
            }
        }
        return stack.arraySymbols[stack.top];
    }
}


struct Symbol freeTemp(){
    if(isEmpty(stack)){
        printf("Stack is empty.\n");
        exit(EXIT_FAILURE);
    }else{
        stack.end = SIZE;
        printf("free temp.\n");
        return stack.arraySymbols[stack.top];
    }
}

struct Symbol freeLastTemp(){
    if(isEmpty(stack)){
        printf("Stack is empty.\n");
        exit(EXIT_FAILURE);
    }else{
        stack.end ++;
        printf("free temp.\n");
        return stack.arraySymbols[stack.top];
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

int findTemp()
{
    return stack.end;
}

int findLastTemp()
{
    return stack.end + 1;
}


void print_stack(){
    printf("ok print\n");
    printf("%d \n",stack.top);
     printf("-----------\n");
     printf("Nom | @ | type | depth \n");
    for(int i=0;i<stack.top+1;i++){
        printf("%s   | %d |  %d   | %d \n",stack.arraySymbols[i].id,stack.arraySymbols[i].address,stack.arraySymbols[i].type,stack.arraySymbols[i].depth);
    }
    for(int i=sizeof(stack);i<stack.end;i--){
        printf("%s   | %d |  %d   | %d \n",stack.arraySymbols[i].id,stack.arraySymbols[i].address,stack.arraySymbols[i].type,stack.arraySymbols[i].depth);
    }
}

int find_symbol(char *name){
    
    for(int i=0;i<=stack.top;i++){
        
        if (strcmp(stack.arraySymbols[i].id,name)==0){
            printf("founded symbol\n");
            return i;
        }
        
    }
    printf("not founded symbol\n");
    return -1;
}
