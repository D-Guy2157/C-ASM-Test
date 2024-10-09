#include <stdio.h>

extern "C" int _isPalindrome(char* str);  

int main() {
    char str[101];  
    printf("Please enter a word: ");
    scanf("%100s", str);  
    int result = _isPalindrome(str);  
    printf("The word '%s' is %sa palindrome.\n", str, result ? "" : "not ");
    return 0;
}