_saveTermois:
	mov rax, [oldTermois]
	
	test rax, rax
	jnz _failSave

	mov rax, 16
	mov rdi, 0
	mov rsi, 0x5401
	mov rdx, oldTermois
	syscall

    ret

_failSave:
	ret

%macro save_termois 0
    call _saveTermois
%endmacro