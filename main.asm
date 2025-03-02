%define ROW 12
%define COL 24


%include "myLib/print_decimal.asm"
%include "myLib/print_flush.asm"
%include "myLib/print_ascii_value.asm"
%include "myLib/print.asm"

%include "myLib/file_open.asm"
%include "myLib/file_read.asm"
%include "myLib/file_close.asm"

%include "myLib/get_input.asm"

%include "myLib/raw_mode.asm"
%include "myLib/save_termois.asm"
%include "myLib/reset_termois.asm"

%include "myLib/sleep.asm"

%include "myLib/rand_int.asm"

%include "myLib/move_ascii_cursor.asm"

%include "myLib/exit.asm"

%include "printGame.asm"
%include "menu.asm"
%include "printMenu.asm"
%include "game.asm"
%include "spawnFruits.asm"
%include "highscore.asm"

section .data
    PRINT_BUFFER_LENGTH dq 0
    rawModeOn db 0

    clear_screen db `\e[2J`, 0

    playerX dq 0
    playerY dq 0
    PlayerFacing dq 0

    fruitX dq 0
    fruitY dq 0

    score dq 0
    highScore dq 0
    highScoreFile db "highScore.txt", 0

section .bss
    PRINT_BUFFER resb PRINT_BUFFER_SIZE
    time resb 16
    timeSinceMovement resb 16

    key resb 4

    oldTermois resb 48
    rawTermios resb 48

    gameMenuSection resb 1


section .text
    global _start


_init:

    get_time
    mov rax, [time]
    mov rbx, [time+8]
    
    mov [timeSinceMovement], rax
    mov [timeSinceMovement+8], rbx

    mov rax, 0
    mov [gameMenuSection], rax

    mov rbx, playerX
    
    mov rcx, ROW
    sub rcx, 2
    
    rand_int 2, rcx
    mov [rbx], rax

    mov rbx, playerY
    

    mov rcx, COL
    sub rcx, 2
    
    rand_int 2, rcx
    mov [rbx], rax

    mov rbx, PlayerFacing
    rand_int 0, 3

    mov [rbx], rax

    call _spawnRandomFruit

    ret


_start:

    load_highscore

    call _init

    print _exitGame.HIDE_CURSOR

    save_termois

    raw_mode

    call _printMenu

    call _MenuLoop

_exitGame:
    move_ascii_cursor 0, 0
    
    print clear_screen
    print .SHOW_CURSOR
    
    print_flush

    save_highscore
    
    reset_termois
    exit              



.HIDE_CURSOR:
	db `\e[?25l`, 0

.SHOW_CURSOR:
	db `\e[?25h`, 0