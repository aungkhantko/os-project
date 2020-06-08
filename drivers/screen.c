#include "ports.h"
#include "screen.h"
#include "../kernel/util.h"
 
/* 
 * Video memory has two bytes per cell. First byte contains
 * a character and the second byte contains the attribute 
 * 
 * The screen has built in registers that can be used to 
 * query or modify the cursor
 */

void clear_screen() 
{
        unsigned char *mem = (unsigned char *) VIDEO_ADDRESS;
        int size = MAX_ROWS * MAX_COLS;

        for (int i = 0; i < size; i++) {
                mem[i++] = ' ';
                mem[i] = WHITE_ON_BLACK;
        }

        set_cursor(0);
}

void print_char(char c, int row, int col, char attr) 
{
        unsigned char *mem = (unsigned char *) VIDEO_ADDRESS;
        int offset;

        if (!attr) attr = WHITE_ON_BLACK;

        if (col >= 0 && row >= 0) {
                offset = get_screen_offset(row, col);
        } else {
                offset = get_cursor_offset();
        }

        if (c == '\n') {
                row = offset / (2 * MAX_COLS) + 1;
                offset = get_screen_offset(row, 0);
        } else {
                mem[offset++] = c;
                mem[offset++] = attr;
        }

        offset = scrolling(offset);
        set_cursor(offset);
}

void print_at(char *string, int row, int col) 
{
        if (col >= 0 && row >= 0)
                set_cursor(get_screen_offset(row, col));

        for (int i = 0; string[i] != 0; i++) {
                print_char(string[i], row, col++, WHITE_ON_BLACK);
        }
}

void print(char *string) 
{
        print_at(string, -1, -1);
}

void set_cursor(int offset) 
{
        offset /= 2;
        port_byte_out(REG_SCREEN_CTRL, 14);
        port_byte_out(REG_SCREEN_DATA, offset >> 8);
        port_byte_out(REG_SCREEN_CTRL, 15);
        port_byte_out(REG_SCREEN_DATA, offset & 0xff);
}

int get_cursor_offset() 
{
        int offset;
        port_byte_out(REG_SCREEN_CTRL, 14);
        offset = port_byte_in(REG_SCREEN_DATA) << 8;
        port_byte_out(REG_SCREEN_CTRL, 15);
        offset += port_byte_in(REG_SCREEN_DATA);
        return offset * 2;
}

int get_screen_offset(int row, int col) 
{
        return (row * MAX_COLS + col) * 2;
}

int scrolling(int offset) 
{
        if (offset < MAX_ROWS * MAX_COLS * 2)
                return offset;

        for (int i = 1; i < MAX_ROWS; i++) {
                memcpy((char *) (get_screen_offset(i, 0) + VIDEO_ADDRESS),
                       (char *) (get_screen_offset(i - 1, 0) + VIDEO_ADDRESS),
                       MAX_COLS * 2);
        }

        char *last = (char *) (get_screen_offset(MAX_ROWS - 1, 0) + VIDEO_ADDRESS);
        for (int i = 0; i < MAX_COLS * 2 - 2; i++) {
                last[i] = 0;
        }

        offset -= 2 * MAX_COLS;
        return offset;
}
