section .text
global ft_strcmp

ft_strcmp:							; rdi = s1, rsi = s2
	xor		r10, r10				; i = 0;

loop:
	mov		cl, BYTE [rdi + r10]	; cl = s1[i]
	mov		dl, BYTE [rsi + r10]	; dl = s2[i]

	cmp		cl, 0					; if (s1[i] == '\0')
	je		end
	cmp		dl, 0					; if (s2[i] == '\0')
	je		end
	cmp		cl, dl					; if (s1[i] == s2[i])
	jne		end
	inc		r10						; i++;
	jmp		loop

end:
	movzx	eax, BYTE [rdi + r10]	; rax = s1[i]
	movzx	edx, BYTE [rsi + r10]	; rdx = s2[i]
	sub		eax, edx				; s1[i] - s2[i]
	ret

