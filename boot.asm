%define boot_location (0x7C00)
%define endfile (0xAA55)
%include "src/annoying.asm"
%include "src/functions.asm"

[org boot_location]
[bits 16]

; Set up the stack
cli
mov ax, cs
mov dx, ax
mov es, ax
mov ss, ax
mov sp, 0x400
sti
; enter lekker video mode
; Set video mode to 80x25
mov ax, 0x0003
int 0x10

; Set cursor shape and position
mov ah, 0x01
mov cx, 0x0607
int 0x10

; Clear the screen
mov ax, 0x0600
mov bx, 0x0700
int 0x10

; Enable PAE
mov eax, cr4
or eax, 1 << 5    ; set PAE bit
mov cr4, eax

; Load the GDT
lgdt [gdt_descriptor]

; Switch to long mode
mov ecx, 0xC0000080    ; EFER MSR
rdmsr
or eax, 1 << 8    ; set LME bit
wrmsr

; Jump to a 64-bit code segment
jmp gdt_code_segment:long_mode_code

; Define the 64-bit code segment
section .code64
gdt_code_segment:
    ; Define a 64-bit code segment descriptor
    dw 0x0000ffff    ; limit 0-15
    dw 0x00cf9a00    ; base 0-15, type, and flags
    db 0x00          ; base 16-23
    db 0x00          ; flags and limit 16-19
    db 0x00          ; base 24-31

; Define the entry point of the 64-bit code
long_mode_code:
    ; Load the kernel code
    mov eax, 0x100000    ; load kernel code at 1MB
    mov ecx, kernel_end - kernel_start
    mov esi, kernel_start
    rep movsb

    ; Jump to the kernel entry point
    jmp gdt_data_segment:kernel_entry

; Define a data segment descriptor
section .data
gdt_data_segment:
    dw 0x0000ffff    ; limit 0-15
    dw 0x00cf9200    ; base 0-15, type, and flags
    db 0x00          ; base 16-23
    db 0x00          ; flags and limit 16-19
    db 0x00          ; base 24-31

; Define the kernel entry point
section .text
kernel_entry:
    mov rax, 0x4869
    print_maybechar

; Include the kernel code
kernel_start:

kernel_end:
    hlt

times 510 - ($ - $$) db 0
dw endfile