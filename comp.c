#include "ts.h"
#include <string.h>

struct instruction {
    char *op;
    int a1;
    int a2;
    int a3;
};


struct instruction ti[2000];
int index_ins = 0;

void compPrintID(char *nom) {
      int address = find_symbol(nom);
      ti[index_ins].op = "PRI";
      ti[index_ins].a1 = address;
      ti[index_ins].a2 = 0;
      ti[index_ins].a3 = 0;
      index_ins++;
}

void compArithID(char *nom) {
      int address = find_symbol(nom);
      int tmpAddress = newIntTmp();
      ti[index_ins].op = "COP";
      ti[index_ins].a1 = tmpAddress;
      ti[index_ins].a2 = address;
      ti[index_ins].a3 = 0;
      index_ins++;
}

void compArithNB(int nb) {
      int tmpAddress = newIntTmp();
      ti[index_ins].op = "AFC";
      ti[index_ins].a1 = tmpAddress;
      ti[index_ins].a2 = nb;
      ti[index_ins].a3 = 0;
      index_ins++;
}

void compAffectation(char *nom) {
      int address = find_symbol(nom);
      int tmpAddress = findTemp();
      ti[index_ins].op = "COP";
      ti[index_ins].a1 = address;
      ti[index_ins].a2 = tmpAddress;
      ti[index_ins].a3 = 0;
      index_ins++;
}

void compAdd() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "ADD";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}

void compSub() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "SOU";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}
void compMul() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "MUL";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}
void compDiv() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "DIV";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}

void compInf() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "INF";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}

void compSup() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "SUP";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}

void compEqu() {
      int tmpAddress = findTemp();
      int tmpAddress2 = findLastTemp();
      ti[index_ins].op = "EQU";
      ti[index_ins].a1 = tmpAddress2;
      ti[index_ins].a2 = tmpAddress2;
      ti[index_ins].a3 = tmpAddress;
      freeLastTemp();
      index_ins++;
}

void printTI() {
    for (int i = 0; i <  index_ins; i++) {
        printf("@%03x: %5s %3d %3d %3d\n", i, ti[i].op, ti[i].a1, ti[i].a2, ti[i].a3);
    }
}