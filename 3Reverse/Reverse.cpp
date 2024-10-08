#include <stdio.h>

extern "C" void _reverseArrays(char* array1, int* array2);

int main() {
    char array1[4] = {1, 2, 3, 4};
    int array2[4] = {10, 20, 30, 40};

    _reverseArrays(array1, array2);

    printf("Reversed array1: ");
    for (int i = 0; i < 4; i++) {
        printf("%d ", (int)array1[i]);
    }

    printf("\nReversed array2: ");
    for (int i = 0; i < 4; i++) {
        printf("%d ", array2[i]);
    }
    printf("\n");

    return 0;
}