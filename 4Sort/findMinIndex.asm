.data

.code
PUBLIC _findMinIndex


_findMinIndex PROC
    mov rbx, rdi           
    mov ecx, esi            
    mov rax, esi           
    mov edx, edx          

    mov eax, [rbx + rsi*4] 
    mov ebx, eax           

find_loop:
    inc ecx                
    cmp ecx, edx           
    jge end_min_search     

    mov eax, [rdi + ecx*4] 
    cmp eax, ebx           
    jge find_loop           

    mov ebx, eax           
    mov esi, ecx            

    jmp find_loop          

end_min_search:
    mov eax, esi            
    ret
_findMinIndex ENDP

END