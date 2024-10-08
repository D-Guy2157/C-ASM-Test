# Assembly Results <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->
- [Compiling](#compiling)
- [\\0TEST](#0test)
  - [main.cpp](#maincpp)
  - [add.asm](#addasm)
  - [.output.txt](#outputtxt)
  - [errors/issues](#errorsissues)
- [\\1Palindrome](#1palindrome)
  - [Palindrome.cpp](#palindromecpp)
  - [isPalindrome.asm](#ispalindromeasm)
  - [.output.txt](#outputtxt-1)
  - [errors/issues](#errorsissues-1)
- [\\2Sum](#2sum)
  - [Sum.cpp](#sumcpp)
  - [computeSum.asm](#computesumasm)
  - [.output.txt](#outputtxt-2)
  - [errors/issues](#errorsissues-2)
- [\\3Reverse](#3reverse)
  - [Reverse.cpp](#reversecpp)
  - [reverseArrays.asm](#reversearraysasm)
  - [.output.txt](#outputtxt-3)
  - [errors/issues](#errorsissues-3)
- [\\4Min](#4min)
  - [Min.cpp](#mincpp)
  - [findMinIndex.asm](#findminindexasm)
  - [.output.txt](#outputtxt-4)
  - [errors/issues](#errorsissues-4)

## Compiling
All of this was compiled using the following commands:

Note: *within VS 2022 Developer Command Prompt*
```cmd
> ml64 /c /Fo assemblyFile.obj assemblyFile.asm
> cl /c /EHsc cppFile.cpp
> cl cppFile.obj assemblyFile.obj
> cppFile.exe
```
## \0TEST
This was just a test one I wrote to make sure the compilers and everything was working, adds 2 predefined numbers.
### main.cpp
```cpp
#include <iostream>

extern "C" int _add(int a, int b);

int main() {
    int num1 = 5;
    int num2 = 10;
    int result = _add(num1, num2);

    std::cout << "The sum of " << num1 << " and " << num2 << " is " << result << std::endl;
    return 0;
}
```
### add.asm
```assembly
.data

.code
PUBLIC _add

_add PROC
    ; Parameters are passed in RCX and RDX (first and second integer arguments)
    mov rax, rcx        ; Load first parameter (a) into rax
    add rax, rdx        ; Add second parameter (b) to rax
    ret                 ; Return with result in rax
_add ENDP

END
```
### .output.txt
```txt
The sum of 5 and 10 is 15

```
### errors/issues
None
## \1Palindrome
Checks if palindrome
### Palindrome.cpp
```cpp
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
```
### isPalindrome.asm
```assembly
.data


.code
PUBLIC _isPalindrome

_isPalindrome PROC
    mov rsi, rdi

 
    mov rcx, -1
    xor al, al
    repne scasb
    dec rdi


    mov rcx, rdi
    sub rcx, rsi
    shr rcx, 1
    jz  palindrome

check_loop:
    cmpsb
    jne not_palindrome
    inc rsi
    dec rdi
    loop check_loop

palindrome:
    mov al, 1
    ret

not_palindrome:
    xor al, al
    ret
_isPalindrome ENDP

END
```
### .output.txt
Piped output:
```txt
Please enter a word: The word 'sus' is not a palindrome.

```
Copied output:
```txt
Please enter a word: sus
The word 'sus' is not a palindrome.

```
### errors/issues
Logic error: Not properly identifying palindromes.
## \2Sum
Sums the numbers of an array
### Sum.cpp
```cpp
#include <stdio.h>

extern "C" int _computeSum(int* array, int size);

int main() {
    int array[8] = { 12, 5, 22, 13, 9, 18, 24, 7 };
    int size = 8;
    int result = _computeSum(array, size);

    printf("The computed sum is: %d\n", result);
    return 0;
}
```
### computeSum.asm
```assembly
.data

.code
PUBLIC _computeSum   

_computeSum PROC
    mov rbx, rdi        
    xor rax, rax        
    mov rcx, rsi        
    shr rcx, 1          

next_pair:
    cmp rcx, 0          
    je end_sum

    mov edx, [rbx]      
    add rbx, 4          
    mov esi, [rdi + rsi*4 - 4] 
    sub edx, esi        
    add rax, rdx        

    sub rsi, 1          
    dec rcx             
    jmp next_pair       

end_sum:
    ret
_computeSum ENDP

END
```
### .output.txt
```txt
The computed sum is: 0

```
### errors/issues
Logic Error: Not summing the items in the array.
## \3Reverse
Reverses the items in an array
### Reverse.cpp
```cpp
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
```
### reverseArrays.asm
```assembly
.data

.code
PUBLIC _reverseArrays

_reverseArrays PROC
    mov rbx, rdi        
    mov rdx, 4          

reverse_loop1:
    cmp rdx, 0          
    je reverse_done1
    push byte ptr [rbx] 
    add rbx, 1          
    dec rdx             
    jmp reverse_loop1   

reverse_done1:
    sub rbx, 4          

reverse_loop2:
    cmp rdx, 4          
    je reverse_done2
    pop byte ptr [rbx]  
    add rbx, 1          
    inc rdx             
    jmp reverse_loop2   

reverse_done2:
    mov rbx, rsi        
    mov rdx, 4          

reverse_loop3:
    cmp rdx, 0          
    je reverse_done3
    push dword ptr [rbx] 
    add rbx, 4          
    dec rdx             
    jmp reverse_loop3   

reverse_done3:
    sub rbx, 16         

reverse_loop4:
    cmp rdx, 4          
    je reverse_done4
    pop dword ptr [rbx] 
    add rbx, 4          
    inc rdx             
    jmp reverse_loop4   

reverse_done4:
    ret
_reverseArrays ENDP

END
```
### .output.txt
```txt
N/A - Did not compile
```
### errors/issues
Compile Errors:
```
Assembling: reverseArrays.asm
reverseArrays.asm(13) : error A2070:invalid instruction operands
reverseArrays.asm(24) : error A2070:invalid instruction operands
reverseArrays.asm(36) : error A2070:invalid instruction operands
reverseArrays.asm(47) : error A2070:invalid instruction operands
```
## \4Min
Finds the minimum index of item using selection sort
### Min.cpp
```cpp
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
```
### findMinIndex.asm
```assembly
.data

.code
PUBLIC _findMinIndex, _selectionSort

_findMinIndex PROC
    mov rbx, rdi
    mov rcx, rsi
    mov rdx, rdx

find_loop:
    add rcx, 1
    cmp rcx, rdx
    jge end_min
    mov eax, [rbx + rcx*4]
    cmp eax, [rbx + rsi*4]
    jl new_min
    jmp find_loop

new_min:
    mov esi, rcx
    jmp find_loop

end_min:
    mov eax, esi
    ret
_findMinIndex ENDP

_selectionSort PROC
    mov rbx, rdi
    mov rdx, rsi
    xor rdi, rdi

sort_loop:
    cmp rdi, rdx
    jge end_sort
    mov rsi, rdi
    call _findMinIndex
    cmp rdi, eax
    je next
    mov ecx, [rbx + rdi*4]
    mov edx, [rbx + eax*4]
    mov [rbx + rdi*4], edx
    mov [rbx + eax*4], ecx

next:
    add rdi, 1
    jmp sort_loop

end_sort:
    ret
_selectionSort ENDP

END
```
### .output.txt
```txt
N/A - Did not compile
```
### errors/issues
Compile Errors:
```
Assembling: findMinIndex.asm
findMinIndex.asm(21) : error A2022:instruction operands must be the same size
findMinIndex.asm(21) : error A2022:instruction operands must be the same size
findMinIndex.asm(42) : error A2082:cannot mix 16- and 32-bit registers
findMinIndex.asm(44) : error A2082:cannot mix 16- and 32-bit registers
```