#ifndef BINARYTREE_ANRU_H
#define BINARYTREE_ANRU_H

typedef struct node {
  int data;
  struct node* left;
  struct node* right;
} node;

static int lookup(node* node,int data);
static int lookup_norec(node* node,int data);
static struct node* NewNode(int data);
static node* insert(node* root,int data);
static node* build123(void);
static node* build123b(void);
static void print_tree(node* root);
static int size(node* node);
#endif