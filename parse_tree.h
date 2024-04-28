#ifndef PARSE_TREE_H
#define PARSE_TREE_H

#include "tree_node.h"
#include <map>
#include <string>
#include <memory>

// Global declaration of root
extern std::shared_ptr<Tree_Node> root;  // Only declare, no definition here

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
        auto node = std::make_shared<Tree_Node>(name->evaluate(), weight->evaluate());
        
        if (isachildof && !isachildof->evaluate().empty()) {
            auto parent_it = sym_tab.find(isachildof->evaluate());
            if (parent_it != sym_tab.end()) {
                parent_it->second->add_child(node);
            }
        } else {
            // Root node case; set global root
            if (!root) {  // Ensure root is only set once as the very first node without a parent
                root = node;
            }
        }
        return node;
    }
};

#endif /* PARSE_TREE_H */
