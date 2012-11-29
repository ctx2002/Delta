#include "BinaryTree.h"
#include "Stack.h"
#include <stdlib.h>
#include <stdio.h>
static int lookup(node* node,int data)
{
  if (0 == node) return 0;
  if (node->data == data) return 1;
  if(data < node->data) return lookup(node->left,data);
  else return  lookup(node->right,data);
}

static int lookup_norec(node* node,int data)
{
  while(1) {
    if (0 == node) return 0;
    if (node->data == data) return 1;
	if (data < node->data) {
		node = node->left;
	} else {
		node = node->right;
	}
  }

  return 0;
}

static struct node* NewNode(int data)
{
  node* n;
  n = (struct node*)malloc(sizeof (struct node));
  n->data = data;
  n->left = 0;
  n->right = 0;
  return n;
}

static node* insert(node* root,int data)
{
	if (0 == root) {
	  return NewNode(data);
	}
	if (data <= root->data) root->left = insert(root->left,data);
	else root->right =  insert(root->right,data);
	return root;
}

static node* build123(void)
{
  node* n1 = NewNode(2);
  n1->left = NewNode(1);
  n1->right = NewNode(3);
  return n1;
}

static node* build123b(void)
{
  node* n = insert(0,2);
  n = insert(n,1);
  n = insert(n,3);
  n = insert(n,-1);
  n = insert(n,-3);
  n = insert(n,4);
  n = insert(n,7);
  n = insert(n,9);
  n = insert(n,5);
  n = insert(n,-5);
  return n;
}

static int size(node* node)
{
	static unsigned int c = 0;
	if (node != 0) {
		size(node->left);
		size(node->right);
		c += 1;
	}
	return c;
}

static void print_tree(node* root)
{
	if(0 != root) {
		print_tree(root->left);
		printf(" %d ",root->data);
		print_tree(root->right); 
	}
}

static int maxDepth(node* node,int level)
{
  static int c = 0;
	if (node == 0) return c;
	if (level > c ) c = level;
  maxDepth(node->left,level+1);
  maxDepth(node->right,level+1);
  return c;
}

static int minValue(node* n)
{
	node* old;
	if(n == 0) return 0;
	while(n) {
		old = n;
		n = n->left;
	}
	return old->data;
}

void printPostorder(node* root)
{
	if(0 != root) {
	  print_tree(root->left);
	  print_tree(root->right);
	  printf(" %d ",root->data);
	}
}

void mirror(node* root)
{
	node* old ;
	if(root){
		mirror(root->left);
		mirror(root->right);
		old = root->left;
		root->left = root->right;
		root->right = old;
	}
}

/*
static int maxDepth_norec(node* node, int level)
{
  int c = 0;
  Stack* s = (struct Stack*) malloc(sizeof(struct Stack));
  Stack_Init(s);
  while(1) {
    if (0 == node) return c;
	if (level > c) c = level;
  }
}
*/

int main(int arg, char **argv)
{
    node* n = build123();
	node* n1 = build123b();
	int c = 0;
	print_tree(n);
	printf("\n");
	printPostorder(n);
	printf("\n");
	print_tree(n1);
	printf("\n");

	mirror(n);
	print_tree(n);
	printf("\n");

	c = size(n1);
	printf("\nsize: %d\n",c);

	c = maxDepth(n1,0);
	printf("\ndepth: %d\n",c);

	c = minValue(n1);
	printf("\nmin: %d\n",c);

	mirror(n1);
	print_tree(n1);
	printf("\n");
	return 0;
}