CC = g++
LEX = flex
YACC = bison
CFLAGS = -std=c++11 -Wall
LIBS = -lfl

all: tree_compiler

tree_compiler: lex.yy.o y.tab.o main.o
	$(CC) $(CFLAGS) -o tree_compiler lex.yy.o y.tab.o main.o $(LIBS)

lex.yy.c: tree_builder.l y.tab.h
	$(LEX) tree_builder.l

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c y.tab.c

y.tab.c y.tab.h: tree_builder.y
	$(YACC) -d tree_builder.y -o y.tab.c

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c

main.o: main.cpp
	$(CC) $(CFLAGS) -c main.cpp

clean:
	rm -f *.o lex.yy.c y.tab.* tree_compiler
