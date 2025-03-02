
%ifndef GET_TIME
%define GET_TIME

_getTime:
    push rax
    push rcx
    push rdi
    push rsi

    mov rax, 96          ; Syscall number for gettimeofday
    mov rdi, time       ; Pointer to the struct timeval
    xor rsi, rsi         ; NULL timezone argument
    syscall   

    pop rsi
    pop rdi
    pop rcx
    pop rax

    ret


%macro get_time 0
    call _getTime
%endmacro

%endif