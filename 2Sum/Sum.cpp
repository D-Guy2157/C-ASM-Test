#include <stdio.h>

extern "C" int _computeSum(int* array, int size);

int main() {
    int array[8] = {12, 5, 22, 13, 9, 18, 24, 7};
    
    int size = sizeof(array) / sizeof(array[0]);

    int result = _computeSum(array, size);

    printf("The computed sum is: %d\n", result);
    return 0;
}