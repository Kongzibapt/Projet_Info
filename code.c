#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include "code.h"
#include <string.h>

void put_instruction(int inst){
    
    char * add;
    char * str;

    FILE * f;
    f = fopen("out.s","w");
    if (!f) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    switch(inst){
        case 0 :
            itoa(findTemp().address,add,10);
            str = strcat("PRI ",add);
            while(gets(str) != NULL){
                fputs(str,f);
            }
            break;

    
    }

    fclose(f);
    exit(EXIT_SUCCESS);
}