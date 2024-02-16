


[org 0x7c00]

; mov bx, string_message_Hello
; call func_print

; mov al, 0x0A
; add al, 0x37
; mov [bx+1], al
; mov ah, 0x0e
; int 0x10

; mov bx, 0x0B
; mov al, bh
; add al, 0x30

; mov ah, 0x0e
; int 0x10

; mov al, bl
; add al, 0x30
; add al, 0x0007
; int 0x10

mov dx, 0x1234
call func_print_hex

string_message_Hello:
    db "Hello World", 0


jmp $

%include "boot_print_library.asm"


times 510 - ($ - $$) db 0
dw 0xaa55