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