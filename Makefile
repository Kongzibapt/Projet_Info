GRM=compilator.y
LEX=compilator.l
BIN=compilator

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o ts.o comp.o code.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -v -t $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c

testdecla: all
	echo "main(){int abc;}" | ./compilator

testinstru: all
	echo "main(){a = 6 + 5;}" | ./compilator

testprint: all
	echo "main(){printf(ok);}" | ./compilator

test: all
	cat ./test.txt | ./compilator
