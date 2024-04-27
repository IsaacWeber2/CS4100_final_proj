#include <iostream>
#include <fstream>
#include <string>
#include <memory>
#include "tree_node.h"
#include "parse_tree.h"

// Assuming extern functions from Yacc are available
extern int yyparse();
extern FILE* yyin;
extern int yylineno;

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return EXIT_FAILURE;
    }

    FILE *myfile = fopen(argv[1], "r");
    if (!myfile) {
        std::cerr << "I can't open " << argv[1] << "!" << std::endl;
        return EXIT_FAILURE;
    }

    yyin = myfile;

    do {
        yyparse();
    } while (!feof(yyin));
    
    fclose(myfile);

    return EXIT_SUCCESS;
}
