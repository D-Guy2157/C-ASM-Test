#include <stdio.h>
#include <time.h>  

extern "C" int _findMinIndex(int* array, int start, int size);  

void selectionSort(int* array, int size) {
    for (int i = 0; i < size - 1; i++) {
        int minIndex = _findMinIndex(array, i, size);  
        int temp = array[i];                           
        array[i] = array[minIndex];
        array[minIndex] = temp;
    }
}

int main() {
    int array[10] = {29, 10, 14, 37, 13, 9, 33, 27, 21, 5};
    int size = 10;

    printf("Original array: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    clock_t start_asm = clock();  
    selectionSort(array, size);  
    clock_t end_asm = clock();    

    double duration_asm = ((double)(end_asm - start_asm)) / CLOCKS_PER_SEC;

    printf("Sorted array: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    printf("Assembly sort time: %f seconds\n", duration_asm);

    return 0;
}