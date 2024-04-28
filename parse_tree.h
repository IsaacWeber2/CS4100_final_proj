#ifndef PARSE_TREE_H
#define PARSE_TREE_H

#include "tree_node.h"
#include <map>
#include <string>
#include <memory>
#include <iostream>

// Global declaration of root
extern std::shared_ptr<Tree_Node> root;

class IntegerExpression {
public:
    int value;

    explicit IntegerExpression(int val) : value(val) {}

    int evaluate() const {
        return value;
    }
};

class StringExpression {
public:
    std::string value;

    explicit StringExpression(std::string val) : value(std::move(val)) {}

    std::string evaluate() const {
        return value;
    }
};

class BuildStatement {
public:
    std::shared_ptr<StringExpression> name;
    std::shared_ptr<IntegerExpression> weight;
    std::shared_ptr<StringExpression> isachildof;

    BuildStatement(std::shared_ptr<StringExpression> n, std::shared_ptr<IntegerExpression> w, std::shared_ptr<StringExpression> childOf)
        : name(std::move(n)), weight(std::move(w)), isachildof(std::move(childOf)) {}

    std::shared_ptr<Tree_Node> evaluate(std::map<std::string, std::shared_ptr<Tree_Node>>& sym_tab) {
        auto node_name = name->evaluate();
        auto node = std::make_shared<Tree_Node>(node_name, weight->evaluate());
        std::cout << "Creating node: " << node_name << " with weight " << node->weight << std::endl;

        if (isachildof) {
            auto parent_name = isachildof->evaluate();
            std::cout << "Child of: " << parent_name << std::endl;
            auto parent_it = sym_tab.find(parent_name);
            if (parent_it != sym_tab.end()) {
                parent_it->second->add_child(node);
                std::cout << "Added " << node_name << " as a child of " << parent_name << std::endl;
            } else {
                std::cerr << "Parent not found: " << parent_name << std::endl;
            }
        } else {
            if (!root) {
                root = node;
                std::cout << "Set as root: " << node_name << std::endl;
            }
        }
        sym_tab[node_name] = node;
        return node;
    }
};

#endif /* PARSE_TREE_H */
