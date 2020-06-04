#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

#define WHITE_ON_BLACK 0x0f

#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

void print_char(char c, int row, int col, char attr);
void set_cursor(int offset);
int get_cursor_offset();
int get_screen_offset(int row, int col);
