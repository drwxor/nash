bits 64

global command_exit

section .text

command_exit:
    mov eax, 60
    xor edi, edi
    syscall
