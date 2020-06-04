#include "ports.h"
#include "screen.h"

void clear_screen() {
        unsigned char *mem = (unsigned char*) VIDEO_ADDRESS;

        int size = MAX_ROWS * MAX_COLS;
        for (int i = 0; i < size; i += 2) {
                mem[i] = ' ';
                mem[i+1] = WHITE_ON_BLACK;
        }

        set_cursor(0);
}

void print_char(char c, int row, int col, char attr) {
        unsigned char *mem = (unsigned char*) VIDEO_ADDRESS;

        if (!attr) attr = WHITE_ON_BLACK;

        int offset;
        if (col >= 0 && row >= 0) 
                offset = get_screen_offset(row, col);
        else
                offset = get_cursor_offset();

        mem[offset] = c;
        mem[offset+1] = attr;

        offset += 2;
        set_cursor(offset);
}

int get_cursor_offset() {
        int offset;
        port_byte_out(REG_SCREEN_CTRL, 14);
        offset = port_byte_in(REG_SCREEN_DATA) << 8;
        port_byte_out(REG_SCREEN_CTRL, 15);
        offset += port_byte_in(REG_SCREEN_DATA);
        return offset * 2;
}

void set_cursor(int offset) {
        offset /= 2;
        port_byte_out(REG_SCREEN_CTRL, 14);
        port_byte_out(REG_SCREEN_DATA, offset >> 8);
        port_byte_out(REG_SCREEN_CTRL, 15);
        port_byte_out(REG_SCREEN_DATA, offset & 0xff);
}

int get_screen_offset(int row, int col) {
        return (row * MAX_ROWS + col) * 2;
}
