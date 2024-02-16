
mov bl, "6"
mov cl, "5"
mov ah, 0x0e

cmp bl, cl
jl if_true_jump
jmp else_jump
jmp code_end

if_true_jump:
    mov al, bl
    int 0x10
    jmp code_end

else_jump:
    mov al, cl
    int 0x10

code_end:
    



jmp $

times 510 - ($ - $$) db 0
dw 0xaa55