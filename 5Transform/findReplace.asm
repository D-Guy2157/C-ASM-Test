.data

.code
PUBLIC find_first_char, replace_char

find_first_char PROC
    mov rsi, rdi             
    xor rdx, rdx             

find_loop:
    cmp byte ptr [rsi + rdx], 0 
    je not_found

    mov al, byte ptr [rsi + rdx] 

    cmp al, sil             
    je found_char
    cmp al, dl              
    je found_char
    cmp al, cl              
    je found_char

    inc rdx                
    jmp find_loop          

found_char:
    mov eax, edx            
    ret

not_found:
    mov eax, -1             
    ret
find_first_char ENDP

replace_char PROC
    mov rsi, rdi            
    mov eax, esi            

    mov al, byte ptr [rsi + rdx] 
    cmp al, sil             
    je replace_with_c2
    cmp al, dl              
    je replace_with_c3
    cmp al, cl              
    je replace_with_c1

replace_with_c2:
    mov byte ptr [rsi + rdi], dl 
    ret

replace_with_c3:
    mov byte ptr [rsi + rdi], cl 
    ret

replace_with_c1:
    mov byte ptr [rsi + rdi], sil 
    ret
replace_char ENDP

END