struct Symbol {
    char* id;
    int address;
    int type;
    int depth;
};

void createStackSymbols();

int isEmpty();

void pushSymbol(struct Symbol newSymbol);

struct Symbol popSymbol(int depth);

struct Symbol findTop();

struct Symbol findTemp();

void print_stack();

int find_symbol(char *name);