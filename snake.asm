
_grow:
    mov rax, 1
    add [_snake.snake], rax

    ret

_move:
    ; move the snakes body


_checkDeath:
    ; check if the head has a collision with head.

_printSnake:
    
    mov rax, board

_printSnakeLoop:
    mov bl, byte [rax]

    cmp bl, 0
    je _noSnake ; no snake

    move_ascii_cursor 0, 0
    print _printGame.player

    print_flush

    inc rax


_noSnake:
    jmp _printSnakeLoop



;
; class snake
;   head = (x, y)
;   body = [(x_new, y_new), (x,y), (x, y), (x, y)] 
;   
;   4 bit per x and y. and n*n per () = (4 + 4) * (n * n) = O(n^2) space
;
; class snake
;   head = (x, y)
;   board = [[0, 1, 2],
;            [0, 4, 3]
;            [0, x, 0]]
;
;   4 bit per n = O(n) space
;