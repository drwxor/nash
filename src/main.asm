bits 64

global _start
global buffer

extern print_prompt
extern read_line

extern command_clear
extern command_exit
extern command_echo
extern command_printf

section .bss
    buffer resb 256

section .rodata
    exit_cmd db "exit", 10
    exit_len equ $ - exit_cmd

    clear_cmd db "clear", 10
    clear_len equ $ - clear_cmd

    echo_cmd db "echo "
    echo_len equ $ - echo_cmd

    printf_cmd db "printf "
    printf_len equ $ - printf_cmd

section .text

_start:
    cld

.loop:
    call print_prompt
    call read_line

    test rax, rax
    jz .exit

    jmp .run_cmd

.run_cmd:
    jmp .check_printf

.check_printf:
    ; check
    cmp rax, printf_len
    jb .check_echo

    mov rdi, buffer
    mov rsi, printf_cmd
    mov rcx, printf_len
    repe cmpsb
    jne .check_echo

    ; call
    lea rdi, [buffer + printf_len]
    sub rax, printf_len
    mov rsi, rax

    call command_printf
    jmp .loop

.check_echo:
    ; check
    cmp rax, echo_len
    jb .check_exit

    mov rdi, buffer
    mov rsi, echo_cmd
    mov rcx, echo_len
    repe cmpsb
    jne .check_exit

    ; call
    lea rdi, [buffer + echo_len]
    sub rax, echo_len
    mov rsi, rax

    call command_echo
    jmp .loop

.check_exit:
    ; check
    cmp rax, exit_len
    jne .check_clear

    mov rdi, buffer
    mov rsi, exit_cmd
    mov rcx, exit_len
    repe cmpsb
    jne .check_clear

    ; call
    call command_exit

.check_clear:
    ; check
    cmp rax, clear_len
    jne .loop

    mov rdi, buffer
    mov rsi, clear_cmd
    mov rcx, clear_len
    repe cmpsb
    jne .loop

    ; call
    call command_clear

    jmp .runloop

.runloop:
    jmp .loop

.exit:
    mov eax, 60
    xor edi, edi
    syscall
