all: tree_compiler

tree_compiler: lex.yy.c y.tab.c
	g++ -o tree_compiler y.tab.c lex.yy.c -lfl -std=c++11

lex.yy.c: tree_builder.l y.tab.h
	lex tree_builder.l

y.tab.c y.tab.h: tree_builder.y
	yacc -d tree_builder.y

test_lex: lex.yy.c y.tab.h
	g++ -DLEX_TEST -o test_lex lex.yy.c y.tab.c -lfl -std=c++11
	./test_lex

test_yacc: lex.yy.c y.tab.c
	g++ -DYACC_TEST -o test_yacc y.tab.c lex.yy.c -lfl -std=c++11
	./test_yacc

clean:
	rm -f lex.yy.c y.tab.c y.tab.h tree_compiler test_lex test_yacc
