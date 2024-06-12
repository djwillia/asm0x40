#include <stdio.h>

int main(int argc, char **argv) {
    FILE *f = fopen("banner.txt", "r");
    int c = fgetc(f);
    do {
        printf("\t__out 0x3f8, 0x%x\n", c);
        c = fgetc(f);
    } while(c != EOF);
}
