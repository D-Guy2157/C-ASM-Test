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