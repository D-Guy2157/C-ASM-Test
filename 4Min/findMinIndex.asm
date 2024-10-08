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