# Assembly Results <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->
- [Compiling](#compiling)
- [\\0TEST](#0test)
  - [main.cpp](#maincpp)
  - [add.asm](#addasm)
  - [.output.txt](#outputtxt)
- [\\1Palindrome](#1palindrome)
  - [Palindrome.cpp](#palindromecpp)
  - [isPalindrome.asm](#ispalindromeasm)
  - [.output.txt](#outputtxt-1)
  - [errors/issues](#errorsissues)
- [\\2Sum](#2sum)
  - [Sum.cpp](#sumcpp)
  - [computeSum.asm](#computesumasm)
  - [.output.txt](#outputtxt-2)
  - [errors/issues](#errorsissues-1)
- [\\3Reverse](#3reverse)
  - [Reverse.cpp](#reversecpp)
  - [reverseArrays.asm](#reversearraysasm)
  - [.output.txt](#outputtxt-3)
  - [errors/issues](#errorsissues-2)
- [\\4Sort](#4sort)
  - [Sort.cpp](#sortcpp)
  - [findMinIndex.asm](#findminindexasm)
  - [.output.txt](#outputtxt-4)
  - [errors/issues](#errorsissues-3)
- [\\5Transform](#5transform)
  - [Transform.cpp](#transformcpp)
  - [findReplace.asm](#findreplaceasm)
  - [.output.txt](#outputtxt-5)
  - [errors/issues](#errorsissues-4)

## Compiling
All of this was compiled using the following commands:

Note: *within x64 Native Tools Command Prompt VS 2022*
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
## \1Palindrome
Checks if palindrome
### Palindrome.cpp
C++ Source File
### isPalindrome.asm
Assembly Source File
### .output.txt
Output 1:
```txt
Please enter a word: sus
The word 'sus' is a palindrome.

```
Output 2:
```txt
Please enter a word: sus
The word 'sus' is not a palindrome.
```
### errors/issues
Logic Error: The first value after compilation is always a palindrome, everything after is not.
## \2Sum
Sums the numbers of an array
### Sum.cpp
C++ Source File
### computeSum.asm
Assembly Source File
### .output.txt
```txt
The computed sum is: 0

```
### errors/issues
Logic Error: Not summing the items in the array, always outputs 0.
## \3Reverse
Reverses the items in an array
### Reverse.cpp
C++ Source File
### reverseArrays.asm
Assembly Source File
### .output.txt
```txt
<Blank>
```
### errors/issues
Logic Error: Nothing is output
*Note: Likely getting stuck in a loop, takes a while to finish*
## \4Sort
Finds the minimum index of item using selection sort
### Sort.cpp
C++ Source File
### findMinIndex.asm
Assembly Source File
### .output.txt
```txt
N/A - Failed to compile
```
### errors/issues
Compile Errors:
```
 Assembling: findMinIndex.asm 
selectionSort.asm(10) : error A2022:instruction operands must be the same size
selectionSort.asm(21) : error A2082:cannot mix 16- and 32-bit registers
```
## \5Transform
Transforms a given string
### Transform.cpp
C++ Source File
### findReplace.asm
Assembly Source File
### .output.txt
```txt
Original string: bonjour tout le monde
Transformed string: bonjour tout le monde

```
### errors/issues
Logic Error: String is not being modified