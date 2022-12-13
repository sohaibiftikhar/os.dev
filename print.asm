;
; A simple BSP that prints a character during booting.
;

mov ah, 0x0e									; int 10/ah = 0eh -> scrolling teletype BIOS routine.
print:
mov al, 'H'										; mov character to print to al.
int 0x10											; interrupt the processor! This calls interrupt routine specified by ah.
mov al, 'e'										; and again the same
int 0x10
mov al, 'l'										; and again the same
int 0x10
mov al, 'l'										; and again the same
int 0x10
mov al, 'o'										; and again the same
int 0x10
mov al, 0x0a									; and finally the line feed
int 0x10
jmp print

jmp $													; jump to the current address i.e. loop forever.

times 510-($-$$) db 0					; Padding the rest of the boot sector.
dw 0xaa55											; Last two bytes (one word) form the magic boot sector; so BIOS knows we are boot sector.
