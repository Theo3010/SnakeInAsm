_sidesLoop:
    print _printGame.sides
    dec rax
    test rax, rax
    jnz _sidesLoop

    ret

_printGame:

    print clear_screen
    move_ascii_cursor 0, 0
    


    print .topEdge

    mov rax, ROW
    sub rax, 2
    call _sidesLoop

    print .BotEdge

    move_ascii_cursor [fruitX], [fruitY]
    print .apple

    move_ascii_cursor [playerX], [playerY]
    print .player

    move_ascii_cursor 4, 28

    print .score

    print_decimal [score]

    move_ascii_cursor 6, 28

    print .highScore

    print_decimal [highScore]

    print_flush

    ret


.score:
    db `Score: `, 0
.highScore:
    db `highScore: `, 0

.topEdge:
    db `┌──────────────────────┐\r\n`, 0
.sides:
    db `│                      │\r\n`, 0
.BotEdge:
    db `└──────────────────────┘\r\n`, 0

.player:
    db `\u2588\u2588`, 0

.apple:
    db `\U1F34E`, 0
