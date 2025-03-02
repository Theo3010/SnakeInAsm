_exit:

    mov rax, 60
    mov rdi, 0
    syscall


%macro exit 0
    call _exit
%endmacro