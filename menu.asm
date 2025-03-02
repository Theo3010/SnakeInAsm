_MenuLoop:
    xor rax, rax
    mov [key], rax
    
    get_input key, 4

    cmp dword [key], 0x00415b1b ; up arrow
    je _up

    cmp dword [key], 0x00425b1b ; down arrow
    je _down

    cmp dword [key], 13 ; Enter key
    je _enter

    cmp dword [key], 113 ; q
    je _exitGame

    jmp _MenuLoop


_enter:
    mov rcx, [gameMenuSection]

    cmp rcx, 0
    je _gameLoopCall

    cmp rcx, 1
    je _exitGame

    cmp rcx, 2
    je _clearScore

    jmp _repaint

_gameLoopCall:
    call _gameLoop

_clearScore:
    ; clear score

    jmp _repaint

_up:
    mov rcx, 1
    sub [gameMenuSection], rcx
    jmp _repaint
_down:
    mov rcx, 1
    add [gameMenuSection], rcx

_repaint:
    mov rcx, [gameMenuSection]
    cmp rcx, -1
    je _overflowUp

    cmp rcx, 3
    je _overflowDown

    jmp _skip

_overflowUp:
    mov rcx, 2
    mov [gameMenuSection], rcx
    jmp _skip

_overflowDown:
    mov rcx, 0
    mov [gameMenuSection], rcx
    jmp _skip

_skip:
    call _printMenu
    jmp _MenuLoop


_exitMenuLoop:
    ret