struct Symbol {
    char* id;
    int address;
    int type;
    int depth;
};

void createStackSymbols();

int isEmpty();

int pushSymbol(struct Symbol newSymbol);

int newIntTmp();

int newInt(char *nom);

struct Symbol popSymbol(int depth);

struct Symbol findTop();

int findTemp();

void print_stack();

int find_symbol(char *name);