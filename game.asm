_gameLoop:

    call _getTimeSinceMovement

    cmp rbx, rdx
    jge _skipRepaint

    get_time
    mov rax, [time]
    mov rbx, [time+8]
    
    mov [timeSinceMovement], rax
    mov [timeSinceMovement+8], rbx

    call _printGame

_skipRepaint:
    get_time

    mov rax, [PlayerFacing]

    cmp rax, 0
    je _gameLoopUp

    cmp rax, 1
    je _gameLoopRight
    
    cmp rax, 2
    je _gameLoopDown
    
    cmp rax, 3
    je _gameLoopLeft

_returnMovement:

    ; reset key
    xor rax, rax
    mov [key], rax
    
    get_input key, 4

    cmp dword [key], 0x00415b1b  ; up
    je _turnUp
    
    cmp dword [key], 0x00435b1b  ; right
    je _turnRight
    
    cmp dword [key], 0x00425b1b  ; down
    je _turnDown
    
    cmp dword [key], 0x00445b1b  ; left
    je _turnLeft

    cmp dword [key], 113         ; q
    je _returnToMenu

_returnControl:

    jmp _checkEgde
_egdeReturn:
    jmp _checkFruit

_returnToMenu:

    mov rax, [score]
    mov rbx, [highScore]
    cmp rax, rbx
    jge _setNewHighScore

_skipScore:
    call _init

    ret


_setNewHighScore:

    mov rax, [score]
    mov rbx, highScore
    mov [rbx], rax

    jmp _skipScore


_checkFruit:

    push rax
    push rbx
    push rcx
    push rdx

    mov rax, [playerX]
    mov rbx, [playerY]

    mov rcx, [fruitX]
    mov rdx, [fruitY]

    cmp rax, rcx ; check x = 0
    jne _noScore

    cmp rbx, rdx ; check y = 0
    jne _noScore
   
    mov rax, 1
    add [score], rax

    call _spawnRandomFruit

_noScore:
    pop rax
    pop rbx
    pop rcx
    pop rdx
    
    jmp _gameLoop

_checkEgde:

    push rax
    push rbx

    mov rax, [playerX]
    mov rbx, [playerY]

    cmp rax, 0 ; check x = 0
    jle _death

    cmp rbx, 0 ; check y = 0
    jle _death
   
    cmp rax, ROW ; check x = 0
    jge _death
   
    cmp rbx, COL ; check x = 0
    jge _death
    
    pop rax
    pop rbx

    jmp _egdeReturn

_death:

    jmp _start

_turnUp:
    mov rbx, PlayerFacing
    mov rdx, 0
    mov [rbx], rdx

    jmp _returnControl

_turnRight:
    mov rbx, PlayerFacing
    mov rdx, 1
    mov [rbx], rdx

    jmp _returnControl

_turnDown:
    mov rbx, PlayerFacing
    mov rdx, 2
    mov [rbx], rdx

    jmp _returnControl

_turnLeft:
    mov rbx, PlayerFacing
    mov rdx, 3
    mov [rbx], rdx

    jmp _returnControl


_getTimeSinceMovement:
    push rax

    mov rax, [timeSinceMovement]
    mov rdx, 1000000
    mul rdx
    add rax, [timeSinceMovement+8]

    add rax, 250000 ; 0.1 secounds

    push rax

    mov rax, [time]
    mov rdx, 1000000
    mul rdx
    add rax, [time+8]

    mov rdx, rax
    pop rbx
    ; retunr rdx = time and rbx = timeSinceMovement + offset

    pop rax

    ret


_gameLoopUp:
    call _getTimeSinceMovement
    cmp rbx, rdx
    jge _returnMovement

    mov rbx, playerX
    mov rdx, 1
    sub [rbx], rdx
    
    jmp _returnMovement

_gameLoopRight:
    call _getTimeSinceMovement
    cmp rbx, rdx
    jge _returnMovement

    mov rbx, playerY
    mov rdx, 1
    add [rbx], rdx

    jmp _returnMovement

_gameLoopDown:
    call _getTimeSinceMovement
    cmp rbx, rdx
    jge _returnMovement

    mov rbx, playerX
    mov rdx, 1
    add [rbx], rdx
    
    jmp _returnMovement

_gameLoopLeft:
    call _getTimeSinceMovement
    cmp rbx, rdx
    jge _returnMovement

    mov rbx, playerY
    mov rdx, 1
    sub [rbx], rdx
    
    jmp _returnMovement