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
- [\\5Transform](#5transform)
  - [Transform.cpp](#transformcpp)
  - [findReplace.asm](#findreplaceasm)
  - [.output.txt](#outputtxt-5)
  - [errors/issues](#errorsissues-5)

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
    mov al, [rbx]       
    push rax            
    add rbx, 1          
    dec rdx             
    jmp reverse_loop1   

reverse_done1:
    sub rbx, 4          

reverse_loop2:
    cmp rdx, 4          
    je reverse_done2
    pop rax             
    mov [rbx], al       
    add rbx, 1          
    inc rdx             
    jmp reverse_loop2   

reverse_done2:
    mov rbx, rsi        
    mov rdx, 4          

reverse_loop3:
    cmp rdx, 0          
    je reverse_done3
    mov eax, [rbx]      
    push rax            
    add rbx, 4         
    dec rdx             
    jmp reverse_loop3   

reverse_done3:
    sub rbx, 16         

reverse_loop4:
    cmp rdx, 4          
    je reverse_done4
    pop rax             
    mov [rbx], eax      
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
<Blank>
```
### errors/issues
Logic Error: Nothing is output
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
    mov ecx, esi           
    mov edx, rdx            

find_loop:
    add ecx, 1             
    cmp ecx, edx            
    jge end_min            
    mov eax, [rbx + ecx*4]  
    cmp eax, [rbx + esi*4]  
    jl new_min             
    jmp find_loop

new_min:
    mov esi, ecx            
    jmp find_loop

end_min:
    mov eax, esi           
    ret
_findMinIndex ENDP

_selectionSort PROC
    mov rbx, rdi            
    mov edx, esi           
    xor esi, esi            

sort_loop:
    cmp esi, edx            
    jge end_sort            
    mov ecx, esi            
    call _findMinIndex      
    cmp esi, eax            
    je next                 

    mov edx, [rbx + esi*4]  
    mov ecx, [rbx + eax*4]
    mov [rbx + esi*4], ecx
    mov [rbx + eax*4], edx

next:
    add esi, 1              
    jmp sort_loop           

end_sort:
    ret
_selectionSort ENDP

END
```
### .output.txt
```txt
Sorted array in C: 5 9 10 13 14 21 27 29 33 37 
Execution time in C: 0.000000 seconds.
```
### errors/issues
Compile Errors: (for ASM)
```
Assembling: selectionSort.asm 
selectionSort.asm(9) : error A2022:instruction operands must be the same size
selectionSort.asm(15) : error A2082:cannot mix 16- and 32-bit registers
selectionSort.asm(16) : error A2082:cannot mix 16- and 32-bit registers
selectionSort.asm(42) : error A2082:cannot mix 16- and 32-bit registers
selectionSort.asm(43) : error A2082:cannot mix 16- and 32-bit registers
selectionSort.asm(44) : error A2082:cannot mix 16- and 32-bit registers
selectionSort.asm(45) : error A2082:cannot mix 16- and 32-bit registers
```
NOTE: Program doesn't require ASM in its current state, but this invalidates the point of this so I'd imagine this is a mistake
## \5Transform
Transforms a given string
### Transform.cpp
```cpp
#include <stdio.h>
#include <string.h>

extern "C" int find_first_char(char* str, char c1, char c2, char c3);  // Assembly procedure declaration
extern "C" void replace_char(char* str, int index, char c1, char c2, char c3);  // Assembly procedure declaration

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
```
### findReplace.asm
```assembly
.data

.code
PUBLIC find_first_char, replace_char

find_first_char PROC
    mov rsi, rdi             ; rsi points to the string (str)
    xor rdx, rdx             ; rdx holds the index (starting at 0)

find_loop:
    cmp byte ptr [rsi + rdx], 0 ; Check if we have reached the end of the string
    je not_found

    mov al, byte ptr [rsi + rdx] ; Load current character into al

    cmp al, sil             ; Compare with c1 (c1 is in sil)
    je found_char
    cmp al, dl              ; Compare with c2 (c2 is in dl)
    je found_char
    cmp al, cl              ; Compare with c3 (c3 is in cl)
    je found_char

    inc rdx                 ; Increment index
    jmp find_loop           ; Repeat loop

found_char:
    mov eax, edx            ; Return the found index in eax (32-bit)
    ret

not_found:
    mov eax, -1             ; Return -1 if no character is found
    ret
find_first_char ENDP

replace_char PROC
    mov rsi, rdi            ; rsi points to the string (str)
    mov rcx, rsi            ; rcx = pointer to the string
    add rcx, rdx            ; Add the index to point to the right character

    mov al, byte ptr [rcx]  ; Load the character at the index

    cmp al, sil             ; Compare with c1 (c1 is in sil)
    je replace_with_c2
    cmp al, dl              ; Compare with c2 (c2 is in dl)
    je replace_with_c3
    cmp al, cl              ; Compare with c3 (c3 is in cl)
    je replace_with_c1

replace_with_c2:
    mov byte ptr [rcx], dl  ; Replace with c2
    ret

replace_with_c3:
    mov byte ptr [rcx], cl  ; Replace with c3
    ret

replace_with_c1:
    mov byte ptr [rcx], sil ; Replace with c1
    ret
replace_char ENDP

END
```
### .output.txt
```txt
Original string: bonjour tout le monde
Transformed string: bonjour tout le monde

```
### errors/issues
Logic Error: String is not being modified