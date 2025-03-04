
_grow:
    ; grow length

_move:
    
    mov rax, board
    mov rcx, 0 ; counter

_moveLoop:
    mov bl, byte [rax]

    inc rax
    inc rcx

    cmp rcx, SQUARES
    je _moveDone

    cmp bl, 0 ; if no snake, then no decrease
    je _noTime

    sub bl, 1

    mov byte [rax], bl

_noTime:
    jmp _moveLoop

_moveDone:
    ret


_checkDeath:
    ; check if the head has a collision with head.

_printSnake:
    
    mov rax, board
    mov rcx, 0 ; counter

_printSnakeLoop:
    mov bl, byte [rax]

    inc rax
    inc rcx

    cmp rcx, SQUARES
    je _printSnakeDone

    cmp bl, 0
    je _noSnake ; no snake

    push rax ; save pointer

    mov rax, rcx
    mov rdx, 0 ; mul
    mov rsi, COL
    div rsi ; rcx / ROW
    push rax ; save result

    mov rax, rcx
    mov rdx, 0 ; mul
    mov rsi, COL
    div rsi ; rcx / ROW
    push rdx ; save result

    pop rdx
    pop rax

    add rax, 2
    add rdx, 1

    move_ascii_cursor 15, 15
    print_decimal rcx
    print_ascii_value 32
    print_decimal COL
    print_ascii_value 32
    print_decimal rax
    print_ascii_value 32
    print_decimal rdx

    move_ascii_cursor rax, rdx
    print _printGame.player
    print_flush

    sleep 2000000

    pop rax ; load pointer

_noSnake:
    jmp _printSnakeLoop

_printSnakeDone:
    ret



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