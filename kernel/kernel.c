#include "../drivers/screen.h"

void main() {
        clear_screen();
        print_char('A', 0, 0, 0);
        print_char('A', 0, 1, 0);
}
