struct Symbol {
    char* id;
    int address;
    int type;
    int depth;
};

void createStackSymbols();

int isEmpty();

void pushSymbol(struct Symbol newSymbol);

struct Symbol popSymbol();

struct Symbol findTop();

void print_stack();

int find_symbol(char *name);