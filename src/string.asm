bits 64

global strcmp

section .text

strcmp:
    .loop:
        mov al, [rdi]
        mov dl, [rsi]

        cmp al, dl
        jne .different

        test al, al
        jz .equal

        inc rdi
        inc rsi
        jmp .loop

    .different:
        movzx eax, al
        movzx edx, dl
        sub eax, edx
        ret

    .equal:
        xor eax, eax
        ret
