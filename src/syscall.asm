bits 64

global sys_write
global sys_read
global sys_exit

section .text

sys_write:
    mov eax, 1
    syscall
    ret

sys_read:
    mov eax, 0
    syscall
    ret

sys_exit:
    mov eax, 60
    syscall
    ret
