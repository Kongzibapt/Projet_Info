#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include "code.h"
#include <string.h>

void flush_file(){
    
    fclose(fopen("out.s","w"));
    
}

void put_instruction(int inst){
    
    char add[30];
    char str[30];
    char instr[30];
    struct Symbol varTemp;

    FILE * f;
    f = fopen("out.s","a+");
    if (!f) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    switch(inst){
        case 0 :
            varTemp = findTemp();
            sprintf(add,"%d",varTemp.address);
            strcpy(instr,"PRI ");
            strcpy(str,strcat(instr,add));
            strcat(str,"\n");
            fputs(str,f);
            break;
        case 1 :
            varTemp = findTemp();
            sprintf(add,"%d",varTemp.address);
            strcpy(instr,"PRI ");
            strcpy(str,strcat(instr,add));
            strcat(str,"\n");
            fputs(str,f);
            break;
        default :
            printf("default\n");
            break;

    
    }

    
    fclose(f);

}