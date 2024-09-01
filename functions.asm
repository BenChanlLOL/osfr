section .text
print_maybechar:
    ; Assume the framebuffer is at address 0xB8000 (VGA text mode)
    mov rdi, 0xB8000
    ; Calculate the offset for the character
    mov al, dil
    mov ah, 0x0F  ; White on black text color
    ; Write the character to the framebuffer
    mov [rdi], rax
    ret