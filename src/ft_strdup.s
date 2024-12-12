section .text
global ft_strdup
extern malloc

ft_strdup:							; rdi = str
	xor		rdx, rdx				; i = 0;

strlen_loop:
	cmp		BYTE [rdi + rdx], 0		; if (str[i] == '\0')
	je		strlen_end
	inc		rdx						; i++;
	jmp		strlen_loop

strlen_end:
	inc		rdx						; i++ pour le '\0';
	push	rdi						; sauvegarde de str
	mov		rdi, rdx				; rdi = i
	call	malloc					; rax = new_str
	cmp		rax, 0					; if (malloc failed)
	je		malloc_error
	pop		rdi						; restauration de str

	xor		rdx, rdx				; i = 0;
strcpy_loop:
	cmp		BYTE [rdi + rdx], 0		; if (*src == '\0')
	je		end
	mov		cl, BYTE [rdi + rdx]	; cl = str[rdx]
	mov		BYTE [rax + rdx], cl	; new_str[rdx] = cl
	inc		rdx						; i++;
	jmp		strcpy_loop

end:
	mov		BYTE [rax + rdx], 0		; new_str[i] = '\0'
	ret								; return new_str

malloc_error:
	xor		rax, rax				; return NULL
	ret