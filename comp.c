#include "ts.h"
#include <string.h>

void compAddSymbol(char * name, int type) {
    // 1. verifier que name n'existe pas
    if (!find_symbol(name)==0){
        struct Symbol newSymbol;
        newSymbol.id = strdup(name);
        newSymbol.type = type;
        pushSymbol(newSymbol);
    }
    
}