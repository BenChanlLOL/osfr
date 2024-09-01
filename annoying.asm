; Define the GDT
gdt_start:
    ; Null descriptor (required by the CPU)
    dd 0
    dd 0

    ; Code segment descriptor (64-bit code segment)
    dw 0x0000ffff    ; limit 0-15
    dw 0x00cf9a00    ; base 0-15, type, and flags
    db 0x00          ; base 16-23
    db 0x00          ; flags and limit 16-19
    db 0x00          ; base 24-31

    ; Data segment descriptor (64-bit data segment)
    dw 0x0000ffff    ; limit 0-15
    dw 0x00cf9200    ; base 0-15, type, and flags
    db 0x00          ; base 16-23
    db 0x00          ; flags and limit 16-19
    db 0x00          ; base 24-31

gdt_end:

; Define the gdt_descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1    ; limit
    dd gdt_start                ; base

print_maybe:
    mov [0xB8000], eax
