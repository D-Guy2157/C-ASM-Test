#include <stdio.h>
#include <time.h>

int findMinIndex(int* array, int start, int size) {
    int minIndex = start;
    for (int i = start + 1; i < size; i++) {
        if (array[i] < array[minIndex]) {
            minIndex = i;
        }
    }
    return minIndex;
}

void selectionSort(int* array, int size) {
    for (int i = 0; i < size - 1; i++) {
        int minIndex = findMinIndex(array, i, size);
        int temp = array[i];
        array[i] = array[minIndex];
        array[minIndex] = temp;
    }
}

int main() {
    int array[10] = { 29, 10, 14, 37, 13, 9, 33, 27, 21, 5 };
    int size = 10;
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    selectionSort(array, size);
    end = clock();
    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("Sorted array in C: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\nExecution time in C: %f seconds.\n", cpu_time_used);

    return 0;
}