section .text
global ft_write
extern __errno_location

ft_write:
	cmp		rsi, 0			; if (buf == NULL)
	je		error_null
	mov		rax, 1			; rax = 1
	syscall
	cmp		rax, 0			; if (rax == 0)
	jl		error
	ret

error:
	neg		rax
	mov		rcx, rax
	call	__errno_location
	mov		[rax], rcx
	mov		rax, -1
	ret

error_null:
	call	__errno_location
	mov		rcx, 14
	mov		[rax], rcx
	mov		rax, -1
	ret
