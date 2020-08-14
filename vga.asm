[bits 32]
; Video Memory starts at 0xb8000
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_vga:
	pusha			; save registers
	mov edx, VIDEO_MEMORY	; move to start of video memory
loop_prints_vga:
	mov al, [ebx]		; move char to al
	mov ah, WHITE_ON_BLACK	; move attributes to ah

	cmp al, 0		; compare to end of string
	je end_prints_vga	; jump to end

	add ebx, 1		; get next character
	add edx, 2		; mov to next cell in memory

	jmp loop_prints_vga
end_prints_vga:
	popa			; restore registers
	ret
