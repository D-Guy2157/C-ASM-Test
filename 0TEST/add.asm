.data

.code
PUBLIC _add

_add PROC
    ; Parameters are passed in RCX and RDX (first and second integer arguments)
    mov rax, rcx        ; Load first parameter (a) into rax
    add rax, rdx        ; Add second parameter (b) to rax
    ret                 ; Return with result in rax
_add ENDP

END
