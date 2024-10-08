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