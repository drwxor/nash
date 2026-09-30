bits 64

global command_printf

section .text

command_printf:
    mov eax, 1
    mov edx, esi
    dec edx
    mov rsi, rdi
    mov edi, 1
    syscall
    ret
