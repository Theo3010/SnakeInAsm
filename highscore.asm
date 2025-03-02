

_saveHighScore:

    push rax
    push rbx
    push rdi
    push rsi
    push rdx
    push r10


    file_open highScoreFile, 65, 0644o

    mov r10, rax ; file desc.

    mov rax, 1 ; write
    mov rdi, r10 ; file desc.
    mov rsi, [highScore]
    mov rdi, 1
    syscall

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

    file_read rax, highScore, 1

    file_close rax

    ret


%macro load_highscore 0
    call _loadHighScore
%endmacro


%macro save_highscore 0
    call _saveHighScore
%endmacro