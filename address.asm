;
; An assembly program that demonstrates addressing.
; We attempt to print the value stored at the location `the_secret`.
;
; [org 0x7c00] ; tell assembler where this program would be loaded. Uncomment to see output change.
mov ah, 0x0e											; interrupt for scrolling teletype BIOS routine.

; First attempt.
mov al, the_secret								; Try to load immediate address of label. This does not correspond to value stored at
int 0x10													; at that offset so this attempt fails.

; Second attempt.
mov al, [the_secret]							; Try to load the value pointed to by the the_secret address. Unfortunately this is
int 0x10													; addressed relatively from start of this routing rather than from start of memory.

; Third attempt.
mov bx, the_secret								; Start with the location pointed by the_secret register.
add bx, 0x7c00										; Add the start of the secret BIOS boot loader mem location. Not location is absolute.
mov al, [bx]											; Move in the value point to at the address bx.
int 0x10													;

; Fourth attempt.
mov al, [0x7c1d]									; Directly address the value 0x7c00 + 0x1d. The latter is the relative address of
int 0x10													; the_secret within this routine (index 29; 30th position).

jmp $															; jump forever.

the_secret:
	db "X"

times 510-($-$$) db 0					; Padding the rest of the boot sector.
dw 0xaa55											; Last two bytes (one word) form the magic boot sector; so BIOS knows we are boot sector.
