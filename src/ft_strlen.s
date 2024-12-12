section .text
global ft_strlen

ft_strlen:							; rdi = str
	xor		rax, rax				; i = 0;

loop:
	cmp		BYTE [rdi + rax], 0		; if (str[i] == '\0')
	je		end
	inc		rax						; i++;
	jmp		loop

end:
	ret
