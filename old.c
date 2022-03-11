#include <stdio.h>
#include <stdlib.h>
#include "ts.h"

struct StackSymbols* stack;
int address;

void createStackSymbols(){
    printf("stack created\n");
    stack = NULL;
    address = 0;
}

int isEmpty(){
    return address == 0;
}

void pushSymbol(struct Symbol newSymbol){
    newSymbol.address=address;
    stack->arraySymbols[stack->top]=newSymbol;
    printf("symbol %s pushed to stack \n",newSymbol.id);

}

struct Symbol popSymbol(){
    if(isEmpty(stack)){
        printf("Stack is empty.\n");
        exit(EXIT_FAILURE);
    }else{
        return stack->arraySymbols[stack->top--];
    }
}

struct Symbol findTop()
{
    if (isEmpty(stack)){
        printf("stack is empty\n");
        exit(EXIT_FAILURE);
    }
    return stack->arraySymbols[stack->top];
}

void print_stack(){
    printf("ok\n");
    for(int i=0;i<sizeof(stack->arraySymbols);i++){
        printf("%s | %d | %s | %d \n",stack->arraySymbols[i].id,stack->arraySymbols[i].address,stack->arraySymbols[i].type,stack->arraySymbols[i].depth);
    }
}
:wq

