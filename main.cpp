#include <iostream>
#include <fstream>
#include <map>
#include "tree_node.h"
#include "parse_tree.h"

std::shared_ptr<Tree_Node> root = nullptr;
std::map<std::string, std::shared_ptr<Tree_Node>> symbol_table;

extern int yyparse();
extern FILE* yyin;

int main(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " name" << std::endl;
        return EXIT_FAILURE;
    }

    FILE *myfile = fopen(argv[1], "r");
    if (!myfile) {
        std::cerr << "Can't open: " << argv[1] << std::endl;
        return EXIT_FAILURE;
    }

    yyin = myfile;
    yyparse();  // paring input file
    fclose(myfile);

    if (root) {  // Checking root
        std::cout << "Root exists. Printing tree:" << std::endl;
        root->print_node();
        std::cout << std::endl;
    } else {
        std::cerr << "Tree will not build" << std::endl;
    }

    return EXIT_SUCCESS;
}
