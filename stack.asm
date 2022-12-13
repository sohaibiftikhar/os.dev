;
; A simple boot sector program that show cases stack memory.
;

mov ah, 0x0e                ; scrolling teletype BIOS routine.

mov bp, 0x8000              ; Set the bottom of the stack a bit far away from the boot mem.
mov sp, bp                  ; At the beginning the bottom and the top of the stack is the same.

push 'A'                    ; Push some characters on the stack. Note that these are added as 16 bit values. As a result
push 'B'                    ; 0x00 will be added in as the MSB.
push 'C'

pop bx                      ; Pop the next value into register b.
mov al, bl                  ; mov lower part of bx (bl) to al.
int 0x10

mov al, [0x7ffe]            ; move into al value stored at [bp] - 2. Proves that stack grows downwards from bp.
int 0x10

jmp $

times 510-($-$$) db 0					; Padding the rest of the boot sector.
dw 0xaa55											; Last two bytes (one word) form the magic boot sector; so BIOS knows we are boot sector.
