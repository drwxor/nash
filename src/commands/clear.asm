bits 64

global command_clear

section .rodata
    clear_sequence db 27, "[2J", 27, "[H"
    clear_sequence_len equ $ - clear_sequence

section .text

command_clear:
    mov eax, 1
    mov edi, 1
    mov rsi, clear_sequence
    mov edx, clear_sequence_len
    syscall
    ret
