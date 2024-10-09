.data

.code
PUBLIC find_first_char, replace_char

find_first_char PROC
    mov rsi, rdi             ; rsi points to the string (str)
    xor rdx, rdx             ; rdx holds the index (starting at 0)

find_loop:
    cmp byte ptr [rsi + rdx], 0 ; Check if we have reached the end of the string
    je not_found

    mov al, byte ptr [rsi + rdx] ; Load current character into al

    cmp al, sil             ; Compare with c1 (c1 is in sil)
    je found_char
    cmp al, dl              ; Compare with c2 (c2 is in dl)
    je found_char
    cmp al, cl              ; Compare with c3 (c3 is in cl)
    je found_char

    inc rdx                 ; Increment index
    jmp find_loop           ; Repeat loop

found_char:
    mov eax, edx            ; Return the found index in eax (32-bit)
    ret

not_found:
    mov eax, -1             ; Return -1 if no character is found
    ret
find_first_char ENDP

replace_char PROC
    mov rsi, rdi            ; rsi points to the string (str)
    mov rcx, rsi            ; rcx = pointer to the string
    add rcx, rdx            ; Add the index to point to the right character

    mov al, byte ptr [rcx]  ; Load the character at the index

    cmp al, sil             ; Compare with c1 (c1 is in sil)
    je replace_with_c2
    cmp al, dl              ; Compare with c2 (c2 is in dl)
    je replace_with_c3
    cmp al, cl              ; Compare with c3 (c3 is in cl)
    je replace_with_c1

replace_with_c2:
    mov byte ptr [rcx], dl  ; Replace with c2
    ret

replace_with_c3:
    mov byte ptr [rcx], cl  ; Replace with c3
    ret

replace_with_c1:
    mov byte ptr [rcx], sil ; Replace with c1
    ret
replace_char ENDP

END