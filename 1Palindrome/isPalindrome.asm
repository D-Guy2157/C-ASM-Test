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