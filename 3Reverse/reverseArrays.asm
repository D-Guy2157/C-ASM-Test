.data

.code
PUBLIC _reverseArrays

_reverseArrays PROC
    mov rbx, rdi            
    mov rcx, 4              

reverse_loop1:
    cmp rcx, 0              
    je reverse_done1
    mov al, [rbx]          
    push ax                 
    add rbx, 1             
    dec rcx                 
    jmp reverse_loop1

reverse_done1:
    sub rbx, 4              

reverse_loop2:
    cmp rcx, 4              
    je reverse_done2
    pop ax                  
    mov [rbx], al           
    add rbx, 1              
    inc rcx                
    jmp reverse_loop2

reverse_done2:
    mov rbx, rsi            
    mov rcx, 4             

reverse_loop3:
    cmp rcx, 0            
    je reverse_done3
    mov eax, [rbx]          
    push rax               
    add rbx, 4              
    dec rcx                 
    jmp reverse_loop3

reverse_done3:
    sub rbx, 16             

reverse_loop4:
    cmp rcx, 4             
    je reverse_done4
    pop rax                 
    mov [rbx], eax         
    add rbx, 4              
    inc rcx                 
    jmp reverse_loop4

reverse_done4:
    ret
_reverseArrays ENDP

END