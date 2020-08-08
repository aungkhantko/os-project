; All print functions will end with a 


; argument passed through bx register
print_string:
	pusha		; save registers
	mov ah, 0xe	; set print type
loop_prints:
	mov cx, [bx]	; copy argument to cx
	cmp cl, 0x0	; compare to null character
	je end_prints	; if null then end
	mov al, cl	; else print
	int 0x10
	add bx, 0x1	; move to next character
	jmp loop_prints	; loop
end_prints:
	call print_newline
	popa		; restore registers
	ret		; return

; argument passed through bx register
; 16 bit mode, 2 bytes, four hex characters
print_hex:
	pusha		; save registers

	mov ah, 0xe	; set print type
	mov al, 0x30	; '0'
	int 0x10
	mov al, 0x78	; 'x'
	int 0x10

	mov cx, 4	; counter
loop_printh:
	cmp cx, 0
	je end_printh
	mov dx, bx	; dx used as temp
	shr dx, 12	; right shift dx by 12
	shl bx, 4	; left shift bx by 4

	cmp dl, 0x9	; convert hex to ascii 
	jg b1_printh
	add dl, 0x30	; ascii 0 - 9
	jmp b2_printh
b1_printh:
	add dl, 0x57	; ascii a - f
b2_printh:
	mov al, dl	; print character
	int 0x10
	sub cx, 1	; subtract counter
	jmp loop_printh	; loop
end_printh:
	call print_newline
	popa		; restore registers
	ret		; return

print_newline:
	mov ah, 0xe
	mov al, 0xd	; carriage return
	int 0x10
	mov al, 0xa	; new line
	int 0x10
	ret
