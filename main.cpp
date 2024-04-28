#include <iostream>
#include <fstream>
#include "tree_node.h"
#include "parse_tree.h"

// Define the root here
std::shared_ptr<Tree_Node> root = nullptr;

extern int yyparse();
extern FILE* yyin;

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return EXIT_FAILURE;
    }

    FILE *myfile = fopen(argv[1], "r");
    if (!myfile) {
        std::cerr << "Can't open file: " << argv[1] << std::endl;
        return EXIT_FAILURE;
    }

    yyin = myfile;
    yyparse();  // Parse the input file
    fclose(myfile);

    if (root) {  // Check if the root is properly initialized
        root->print_node();
        std::cout << std::endl;
    } else {
        std::cerr << "No tree structure has been built." << std::endl;
    }

    return EXIT_SUCCESS;
}
