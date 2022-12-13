;
; A simple boot sector program that loops forever.
;
loop:													; define a label loop.
	jmp loop										; and jump back to it.

times 510-($-$$) db 0					; Tell assembler to pad until 510 bytes with 0s. $ - $$ means `current - beginning`.
dw 0xaa55											; Last two bytes (one word) form the magic boot sector; so BIOS knows we are boot sector.
