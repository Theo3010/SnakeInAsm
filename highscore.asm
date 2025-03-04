_checkHighScore:
    mov rax, [score]
    mov rbx, [highScore]

    cmp rax, rbx
    jge _setNewHighScore

    ret

_setNewHighScore:

    mov rax, [score]
    mov [highScore], rax
    
    ret


_saveHighScore:
    push rax
    push rbx
    push rdi
    push rsi
    push rdx
    push r10

    print_flush

    print_decimal [highScore]

    file_open highScoreFile, 65, 0644o

    mov r10, rax ; file desc.

    mov rax, 1 ; write
    mov rdi, r10 ; file desc.
    mov rsi, PRINT_BUFFER
    mov rdx, [PRINT_BUFFER_LENGTH]
    syscall

    mov rax, 0
    mov [PRINT_BUFFER_LENGTH], rax

    file_close r10

    pop r10
    pop rdx
    pop rsi
    pop rdi
    pop rbx
    pop rax

    ret


_loadHighScore:

    file_open highScoreFile, 0, 0644o

    file_read rax, highScore, 16

    file_close rax

    to_integer highScore
    mov [highScore], rax

    ret


%macro load_highscore 0
    call _loadHighScore
%endmacro


%macro save_highscore 0
    call _saveHighScore
%endmacro