; boot.asm - A simple bootloader that prints "Hello, World!" on the screen

org 0x7c00          ; Origin, the memory address where the bootloader will be loaded

start:
    mov ah, 0x0E    ; BIOS Teletype function
    mov si, msg     ; Load the address of the message into SI

print_char:
    lodsb           ; Load byte at SI into AL and increment SI
    cmp al, 0       ; Check if the end of the string (null terminator)
    je done         ; If so, jump to done
    int 0x10        ; BIOS interrupt to print the character
    jmp print_char  ; Repeat for the next character

done:
    cli             ; Clear interrupts
    hlt             ; Halt the CPU

msg db 'Hello, World!', 0  ; The message to be printed

times 510-($-$$) db 0  ; Fill the rest of the 512-byte sector with zeros
dw 0xAA55              ; Boot signature

; To compile: fasm boot.asm boot.bin
; To test in an emulator: qemu-system-x86_64 -fda boot.bin
