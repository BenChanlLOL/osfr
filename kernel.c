volatile char* video_memory = (volatile char*)0xB8000;

void print_maybechar(char input)
{
    int output;
    asm volatile ("mov [0xB8000], %0" : "=r" (output) : "r" (input) : "memory");
}

void realprint(char *string)
{
    while (*string != 0) {
        print_maybechar(*string);
        string++; // move to the next character
    }
}

void kernel() {
    // initialize the kernel or perform some tasks
    realprint("Hello, World!"); // print a test string
}