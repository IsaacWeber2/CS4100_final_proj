#ifndef PARSE_TREE_H
#define PARSE_TREE_H

#include "tree_node.h"
#include <iostream>
#include <map>

std::map<std::string, TreeNode *> nodeMap;

void build_tree_node(const char *name, int weight, const char *parentName)
{
    TreeNode *node = new TreeNode(std::string(name), weight);
    std::string parentStr(parentName);

    if (nodeMap.find(parentStr) != nodeMap.end())
    {
        TreeNode *parent = nodeMap[parentStr];
        parent->addChild(node);
    }
    nodeMap[std::string(name)] = node;
}

void print_tree(TreeNode *node, int depth = 0)
{
    std::cout << std::string(depth * 2, ' ') << "(" << node->name << "," << node->weight << ")" << std::endl;
    for (TreeNode *child : node->children)
    {
        print_tree(child, depth + 1);
    }
}

#endif
