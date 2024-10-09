.data

.code
PUBLIC _computeSum   

_computeSum PROC
    mov rbx, rdi            
    mov rdx, rdi            
    mov rax, rsi
    shl rax, 2
    sub rax, 4
    add rdx, rax

    xor rax, rax            
    mov rcx, rsi           
    shr rcx, 1              

next_pair:
    cmp rcx, 0              
    je end_sum

    mov eax, [rbx]          
    mov esi, [rdx]         
    sub eax, esi          
    add rax, rax           

    add rbx, 4             
    sub rdx, 4             
    dec rcx                
    jmp next_pair          

end_sum:
    ret
_computeSum ENDP

END