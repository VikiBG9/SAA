#include <stdio.h>
#include <stdlib.h>
typedef char *data;
typedef int keyType;
struct tree
{
    keyType key;
    data info;
    struct tree *left;
    struct tree *right;
};

struct tree *search(keyType key, struct tree *T)
{
    if (NULL == T)
        return NULL;
    else if (key < T->key)
        return search(key, T->left);
    else if (key > T->key)
        return search(key, T->right);
    else
        return T;
}

void insertKey(keyType key, data x, struct tree **T)
{
    if (NULL == *T)
    {
        *T = (struct tree *)malloc(sizeof(**T));
        (*T)->key = key;
        (*T)->info = x;
        (*T)->left = NULL;
        (*T)->right = NULL;
    }
    else if (key < (*T)->key)
        insertKey(key, x, &(*T)->left);
    else if (key > (*T)->key)
        insertKey(key, x, &(*T)->right);
    else
        fprintf(stderr, "Елементът е вече в дървото!\n");
}

struct tree *findMin(struct tree *T)
{
    while (NULL != T->left)
        T = T->left;
    return T;
}

void deleteKey(keyType key, struct tree **T)
{
    if (*T == NULL)
    {
        fprintf(stderr, "Върхът, който трябва да се изключи, липсва!\n");
        return;
    }

    if (key < (*T)->key)
    {
        deleteKey(key, &(*T)->left);
    }
    else if (key > (*T)->key)
    {
        deleteKey(key, &(*T)->right);
    }
    else if ((*T)->left != NULL && (*T)->right != NULL)
    {
        struct tree *replace = findMin((*T)->right);
        (*T)->key = replace->key;
        (*T)->info = replace->info;

        deleteKey(replace->key, &(*T)->right);
    }
    else
    {

        struct tree *temp = *T;

        if ((*T)->left != NULL)
        {
            *T = (*T)->left;
        }
        else
        {
            *T = (*T)->right;
        }

        free(temp);
    }
}

void printTree(struct tree *T)
{
    if (NULL == T)
        return;
    printf("%d ", T->key);
    printTree(T->left);
    printTree(T->right);
}



/* Прав обход (Preorder): Root -> Left -> Right */
void preorder(struct tree *T)
{
    if (T == NULL) return;
    printf("%d ", T->key);
    preorder(T->left);
    preorder(T->right);
}

/* Междинен обход (Inorder): Left -> Root -> Right */
void inorder(struct tree *T)
{
    if (T == NULL) return;
    inorder(T->left);
    printf("%d ", T->key);
    inorder(T->right);
}

/* Обратен обход (Postorder): Left -> Right -> Root */
void postorder(struct tree *T)
{
    if (T == NULL) return;
    postorder(T->left);
    postorder(T->right);
    printf("%d ", T->key);
}


int main()
{
    struct tree *T = NULL, *result;
    int i;
    for (i = 0; i < 10; i++)
    {
        int ikey = (rand() % 20) + 1;
        printf("Вмъква се елемент с ключ %d \n", ikey);
        insertKey(ikey, "someinfo", &T);
    }
    printf("Дърво: ");
    printTree(T);
    printf("\n");

    result = search(5, T);
    printf("Намерен е: %s\n", result->info);

    for (i = 0; i < 10; i++)
    {
        int ikey = (rand() % 20) + 1;
        printf("Изтрива се елемента с ключ %d \n", ikey);
        deleteKey(ikey, &T);
    }
    printf("Дърво: ");
    printTree(T);
    printf("\n");
    return 0;
}