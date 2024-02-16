mov ah, 0x0e ; tty

;mov al, test_data
;int 0x10

;mov al, [test_data]
;int 0x10

mov bx, 0x7c00
add bx, test_data
mov al, [bx]
int 0x10

;mov al, [0x7c2d]
;int 0x10


jmp $

test_data:
    db "X"

times 510 - ($ - $$) db 0
dw 0xaa55