#include <stdint.h>

static inline void outb(uint16_t port, uint8_t val)
{
    __asm__ volatile ( "outb %b0, %w1" : : "a"(val), "Nd"(port) : "memory");
}

static void putc(char c)
{
    outb(0x3f8, c);
}

static void puts(char *s)
{
    int i;
    for (i = 0; s[i] != 0; i++)
        putc(s[i]);
}

static void newline(void) {
    putc(0xa); // line feed
    putc(0xd); // carriage return
}

static void putsn(char *s)
{
    puts(s);
    newline();
}

void start_kernel(void)
{
    putsn("Hello!!");
}
