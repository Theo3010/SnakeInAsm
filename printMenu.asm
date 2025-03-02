_printMenu:
    print clear_screen
    
    move_ascii_cursor 0, 0

    print .GAME_TITLE
    print .GAME_YEAR

    print .HIGH_SCORE_GRAMMAR
    print .NEW_GAME_GRAMMAR
    print .QUIT_GAME_GRAMMAR
    print .CLEAR_SCORE_GRAMMAR

    add rax, 16
    move_ascii_cursor rax, 48
    print_decimal [highScore]
    
    mov rax, [gameMenuSection]
    add rax, 17
    move_ascii_cursor rax, 34

    print .MENU_CURSOR

    print_flush

    ret


    ; db 27, 91, 50, 74, 0

.MENU_CURSOR:
	db `\e[33m>\e[0m `, 0

.GAME_TITLE:
	db `\e[31m                   _____   _   _              _  __   ______     \r\n`
	db `\e[31m                 / ____/  | \\ | |     /\\     | |/ /  |  ____|    \r\n`
	db `\e[31m                | (___    |  \\| |    /  \\    | ' /   | |__       \r\n`
	db `\e[31m                 \\___ \\   | . ' |   / /\\ \\   |  <    |  __|      \r\n`
	db `\e[31m                 ____) |  | |\\  |  / ____ \\  | . \\   | |____     \r\n`
	db `\e[31m                |_____/   |_| \\_/ |_/    \\_\\ |_|\\_\\  \\______|    \r\n`
	db `\n`, 0
.GAME_YEAR:
	db `\e[32m                          ___     ___    ___    _____                     \r\n`
	db `                         |__ \\   / _ \\  |__ \\  | ____|                   \r\n`
	db `                            ) | | | | |    ) | | |__                     \r\n`
	db `                           / /  | | | |   / /  |___ \\                   \r\n`
	db `                          / /_  | |_| |  / /_   ___) |                   \r\n`
	db `                         |____|  \\___/  |____| |____/                    \r\n`
	db `\e[0m\n\n`, 0


.HIGH_SCORE_GRAMMAR:
	db `\t\t\t           HIGH SCORE:   \r\n`, 0
.NEW_GAME_GRAMMAR:
	db `\t\t\t       |   NEW GAME     |\r\n`, 0
.QUIT_GAME_GRAMMAR:
	db `\t\t\t       |   QUIT GAME    |\r\n`, 0
.CLEAR_SCORE_GRAMMAR:
	db `\t\t\t       |   CLEAR RECORD |\r\n`, 0      