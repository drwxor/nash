bits 64

global print_prompt
global read_line
global echo_line

extern buffer

section .data
    prompt db ": "
    prompt_len equ $ - prompt

section .text

print_prompt:
    mov eax, 1
    mov edi, 1
    mov rsi, prompt
    mov edx, prompt_len
    syscall
    ret

read_line:
    mov eax, 0
    xor edi, edi
    mov rsi, buffer
    mov edx, 256
    syscall
    ret

echo_line:
    mov rdx, rax
    mov eax, 1
    mov edi, 1
    mov rsi, buffer
    syscall
    ret
