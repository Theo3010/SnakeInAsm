_spawnRandomFruit:

    mov rbx, fruitX ; save the pointer

    mov rcx, ROW
    sub rcx, 2

    rand_int 1, rcx ; rand nun saved in rax
    add rax, 1

    mov [rbx], rax

    mov rcx, COL
    sub rcx, 2

    rand_int 1, rcx ; rand nun saved in rcx
    add rax, 1
    
    mov rbx, fruitY
    mov [rbx], rax

    ret