#include <stdio.h>

extern "C" int _isPalindrome(char* str);  // Declare the external assembly function

int main() {
    char str[101];  // Buffer for string input
    printf("Please enter a word: ");
    scanf("%100s", str);  // Read a word from the user
    int result = _isPalindrome(str);  // Call the assembly function
    printf("The word '%s' is %sa palindrome.\n", str, result ? "" : "not ");
    return 0;
}