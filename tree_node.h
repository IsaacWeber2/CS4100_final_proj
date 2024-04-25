#ifndef TREE_NODE_H
#define TREE_NODE_H

#include <string>
#include <vector>

class TreeNode
{
public:
  std::string name;
  int weight;
  std::vector<TreeNode *> children;

  TreeNode(std::string n, int w) : name(n), weight(w) {}
  void addChild(TreeNode *child)
  {
    children.push_back(child);
  }
};

#endif
