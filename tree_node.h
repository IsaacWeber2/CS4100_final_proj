#ifndef TREE_NODE_H
#define TREE_NODE_H

#include <string>
#include <vector>
#include <memory>

class Tree_Node {
public:
    std::string name;
    int weight;
    std::vector<std::shared_ptr<Tree_Node>> children;
    
    Tree_Node(const std::string& n, int w) : name(n), weight(w) {}
    
    void add_child(std::shared_ptr<Tree_Node> child) {
        children.push_back(child);
    }
};

#endif /* TREE_NODE_H */
