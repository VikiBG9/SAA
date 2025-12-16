#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

typedef struct TreeNode {
    int value;
    int has_parent;              
    struct TreeNode **children;  
    size_t children_count;
    size_t children_capacity;
} TreeNode;

static void die(const char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(EXIT_FAILURE);
}

TreeNode *tree_node_create(int value) {
    TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
    if (!node) die("Out of memory!");

    node->value = value;
    node->has_parent = 0;
    node->children = NULL;
    node->children_count = 0;
    node->children_capacity = 0;
    return node;
}

size_t tree_node_children_count(const TreeNode *node) {
    return node ? node->children_count : 0;
}

TreeNode *tree_node_get_child(TreeNode *node, size_t index) {
    if (!node || index >= node->children_count) return NULL;
    return node->children[index];
}

int tree_node_add_child(TreeNode *parent, TreeNode *child) {
    if (!parent || !child) return -1;

    if (child->has_parent) {
        return -1;
    }

    if (parent->children_count == parent->children_capacity) {
        size_t new_cap = (parent->children_capacity == 0) ? 2 : parent->children_capacity * 2;
        TreeNode **new_arr = (TreeNode **)realloc(parent->children, new_cap * sizeof(TreeNode *));
        if (!new_arr) return -1;

        parent->children = new_arr;
        parent->children_capacity = new_cap;
    }

    child->has_parent = 1;
    parent->children[parent->children_count++] = child;
    return 0;
}

typedef struct Tree {
    TreeNode *root;
} Tree;

Tree tree_create(int root_value) {
    Tree t;
    t.root = tree_node_create(root_value);
    return t;
}

static void print_dfs_impl(const TreeNode *node, int indent) {
    if (!node) return;

    for (int i = 0; i < indent; i++) putchar(' ');
    printf("%d\n", node->value);

    for (size_t i = 0; i < node->children_count; i++) {
        print_dfs_impl(node->children[i], indent + 3);
    }
}

void tree_print_dfs(const Tree *tree) {
    if (!tree || !tree->root) return;
    print_dfs_impl(tree->root, 0);
}

static void free_node(TreeNode *node) {
    if (!node) return;

    for (size_t i = 0; i < node->children_count; i++) {
        free_node(node->children[i]);
    }
    free(node->children);
    free(node);
}

void tree_free(Tree *tree) {
    if (!tree) return;
    free_node(tree->root);
    tree->root = NULL;
}

int main(void) {
    Tree tree = tree_create(7);

    TreeNode *n19 = tree_node_create(19);
    TreeNode *n1  = tree_node_create(1);
    TreeNode *n12 = tree_node_create(12);
    TreeNode *n31 = tree_node_create(31);

    TreeNode *n21 = tree_node_create(21);

    TreeNode *n14 = tree_node_create(14);
    TreeNode *n23 = tree_node_create(23);
    TreeNode *n6  = tree_node_create(6);

    if (tree_node_add_child(n19, n1)  != 0) die("AddChild error");
    if (tree_node_add_child(n19, n12) != 0) die("AddChild error");
    if (tree_node_add_child(n19, n31) != 0) die("AddChild error");

    if (tree_node_add_child(n14, n23) != 0) die("AddChild error");
    if (tree_node_add_child(n14, n6)  != 0) die("AddChild error");

    if (tree_node_add_child(tree.root, n19) != 0) die("AddChild error");
    if (tree_node_add_child(tree.root, n21) != 0) die("AddChild error");
    if (tree_node_add_child(tree.root, n14) != 0) die("AddChild error");

    tree_print_dfs(&tree);

    tree_free(&tree);
    return 0;
}