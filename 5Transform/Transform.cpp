#include <stdio.h>
#include <string.h>

extern "C" int find_first_char(char* str, char c1, char c2, char c3); // Assembly procedure declaration
extern "C" void replace_char(char* str, int index, char c1, char c2, char c3); // Assembly procedure declaration

int main() {
    char str[] = "bonjour tout le monde";
    char c1 = 'b', c2 = 'o', c3 = 't';

    printf("Original string: %s\n", str);

    int index = 0;
    while ((index = find_first_char(str + index, c1, c2, c3)) != -1) {
        replace_char(str, index, c1, c2, c3);
        index++;  // Move to the next character
    }

    printf("Transformed string: %s\n", str);
    return 0;
}