section .text
global ft_strcpy

ft_strcpy:							; rdi = dest, rsi = src
	xor		rcx, rcx				; i = 0

loop:
	cmp		BYTE [rsi + rcx], 0			; if (*src == '\0')
	je		end
	mov		al, BYTE [rsi + rcx]	; al = src[rcx]
	mov		BYTE [rdi + rcx], al	; dest[rcx] = al
	inc		rcx						; i++;
	jmp		loop

end:
	mov		BYTE [rdi + rcx], 0		; dest[i] = '\0'
	mov		rax, rdi				; return dest
	ret
