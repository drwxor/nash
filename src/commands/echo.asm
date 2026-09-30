bits 64

global command_echo

section .text

command_echo:
    mov eax, 1
    mov edx, esi
    mov rsi, rdi
    mov edi, 1
    syscall
    ret
