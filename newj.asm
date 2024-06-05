include inout.asm
.model small, c
.stack 100h

.data
    msg db 'Enter a binary number: $'
    binery db 32 dup(0)
    nl db 13, 10, '$'
    output_msg db 'Binary representation: $'

.code
.startup 

    call puts, offset msg
    call gets, offset binery
    mov si, offset binery
    xor bx, bx

convert_loop:
    mov al, [si]
    cmp al, '$'
    je done
    cmp al, 13   
    je skip_char
    cmp al, 10   
    je skip_char
    sub al, '0'
    shl bx, 1
    or bx, al
    skip_char:
    inc si
    jmp convert_loop

done:
    lea dx, nl
    mov ah, 09h
    int 21h
    lea dx, output_msg
    mov ah, 09h
    int 21h
    mov cx, 32
    mov si, offset binery

convert_binary_loop:
    mov dl, '0'
    test bx, 1
    jz zero_bit
    mov dl, '1'
zero_bit:
    mov ah, 02h
    int 21h
    mov [si], dl
    inc si
    shr bx, 1
    loop convert_binary_loop

    mov dl, '$'
    mov ah, 02h
    int 21h

.exit
end
