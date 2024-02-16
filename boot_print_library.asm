
func_print:
    pusha

    check:
        ;bx stores the memory address of the defined string label and ax points to the memory stored in bx
        mov al, [bx]
        ; string ends with character 0 --> terminating condition
        cmp al, 0
        je done

        mov ah, 0x0e ; setup tty mode
        int 0x10

        add bx, 1 ; every increment points to the next character's ascii value
        jmp check

    done:
        popa
        ret



func_print_hex:
    pusha
    mov cx, 1   ; iterator variable

    hex_loop:
        cmp cx, 4
        jle hex_compute
        jmp hex_done

    hex_compute:            
        mov ax, dx
        and ax, 0xf000  ; 0x1234 and 0xf000 --> 0x10 0x00 or 0x1000
        mov al, ah  ; ah: 0x10 and al: 0x00 now we copy the data to al
        
        
        shr al, 4   ; the number has to be at the last bit => 0x10 --> 0x01
        ; this is quite important bcs when we add 0x30 to make it ascii we can only handle from 0-f for 1 digit i.e, unit's place

        ; 0's ascii value is 48 --> 0x30 
        add al, 0x30
        
        ; but if its > 9 i.e {A,B,C,D,E,F} then we have to convert 10 --> A, 11 --> B and so on till 15 --> F
        ; 9's ascii value is 0x09 + 0x30 --> 0x39
        cmp al, 0x39
        jle hex_pos
        
        
        ; 10's ascii value is 58 but A's ascii value in decimal is 65 --> we add 7 if the hex value is greater than 0x39
        add ax, 0x0007
                
    hex_pos:
        mov bx, base_hex_in_ascii + 1   ; base address of the hex string 
        add bx, cx  ; add the index of the character --> iterator variable

        mov [bx], al

        shl dx, 4   ; shift the original hex number => 0x1234 --> 0x2340 --> 0x3400 --> 0x4000 --> 0x0000
        add cx, 1   ; increment loop/iterator variable
        jmp hex_loop

    hex_done:
        mov bx, base_hex_in_ascii
        call func_print
        popa
        ret

    base_hex_in_ascii:
        db '0x0000', 0