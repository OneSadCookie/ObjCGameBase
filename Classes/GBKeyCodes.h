#ifndef GBKeyCodes_h
#define GBKeyCodes_h

#if defined(__OBJC__)
#import <Foundation/Foundation.h>
#endif

#define GB_KEYBOARD_A                           0x00
#define GB_KEYBOARD_S                           0x01
#define GB_KEYBOARD_D                           0x02
#define GB_KEYBOARD_F                           0x03
#define GB_KEYBOARD_H                           0x04
#define GB_KEYBOARD_G                           0x05
#define GB_KEYBOARD_Z                           0x06
#define GB_KEYBOARD_X                           0x07
#define GB_KEYBOARD_C                           0x08
#define GB_KEYBOARD_V                           0x09
                                             /* 0x0a */
#define GB_KEYBOARD_B                           0x0b
#define GB_KEYBOARD_Q                           0x0c
#define GB_KEYBOARD_W                           0x0d
#define GB_KEYBOARD_E                           0x0e
#define GB_KEYBOARD_R                           0x0f
#define GB_KEYBOARD_Y                           0x10
#define GB_KEYBOARD_T                           0x11
#define GB_KEYBOARD_1                           0x12
#define GB_KEYBOARD_2                           0x13
#define GB_KEYBOARD_3                           0x14
#define GB_KEYBOARD_4                           0x15
#define GB_KEYBOARD_6                           0x16
#define GB_KEYBOARD_5                           0x17
#define GB_KEYPAD_EQUAL_SIGN                    0x18
#define GB_KEYBOARD_9                           0x19
#define GB_KEYBOARD_7                           0x1a
#define GB_KEYBOARD_HYPHEN                      0x1b
#define GB_KEYBOARD_8                           0x1c
#define GB_KEYBOARD_0                           0x1d
#define GB_KEYBOARD_CLOSE_BRACKET               0x1e
#define GB_KEYBOARD_O                           0x1f
#define GB_KEYBOARD_U                           0x20
#define GB_KEYBOARD_OPEN_BRACKET                0x21
#define GB_KEYBOARD_I                           0x22
#define GB_KEYBOARD_P                           0x23
#define GB_KEYBOARD_RETURN_OR_ENTER             0x24
#define GB_KEYBOARD_L                           0x25
#define GB_KEYBOARD_J                           0x26
#define GB_KEYBOARD_QUOTE                       0x27
#define GB_KEYBOARD_K                           0x28
#define GB_KEYBOARD_SEMICOLON                   0x29
#define GB_KEYBOARD_BACKSLASH                   0x2a
#define GB_KEYBOARD_COMMA                       0x2b
#define GB_KEYBOARD_SLASH                       0x2c
#define GB_KEYBOARD_N                           0x2d
#define GB_KEYBOARD_M                           0x2e
#define GB_KEYBOARD_PERIOD                      0x2f
#define GB_KEYBOARD_TAB                         0x30
#define GB_KEYBOARD_SPACEBAR                    0x31
#define GB_KEYBOARD_GRAVE_ACCENT_AND_TILDE      0x32
#define GB_KEYBOARD_DELETE_OR_BACKSPACE         0x33
                                             /* 0x34 */
#define GB_KEYBOARD_ESCAPE                      0x35
#define GB_KEYBOARD_RIGHT_COMMAND               0x36
#define GB_KEYBOARD_LEFT_COMMAND                0x37
#define GB_KEYBOARD_LEFT_SHIFT                  0x38
                                             /* 0x39 */
#define GB_KEYBOARD_LEFT_ALT                    0x3a
#define GB_KEYBOARD_LEFT_CONTROL                0x3b
#define GB_KEYBOARD_RIGHT_SHIFT                 0x3c
#define GB_KEYBOARD_RIGHT_ALT                   0x3d
#define GB_KEYBOARD_RIGHT_CONTROL               0x3e
                                             /* 0x3f */
#define GB_KEYBOARD_F17                         0x40   
#define GB_KEYPAD_PERIOD                        0x41
                                             /* 0x42 */
#define GB_KEYPAD_ASTERISK                      0x43
                                             /* 0x44 */
#define GB_KEYPAD_PLUS                          0x45
                                             /* 0x46 */
                                             /* 0x47 */
                                             /* 0x48 */
                                             /* 0x49 */
                                             /* 0x4a */
#define GB_KEYPAD_SLASH                         0x4b
#define GB_KEYPAD_ENTER                         0x4c
                                             /* 0x4d */
#define GB_KEYPAD_HYPHEN                        0x4e
#define GB_KEYBOARD_F18                         0x4f   
#define GB_KEYBOARD_F19                         0x50   
                                             /* 0x51 */
#define GB_KEYPAD_0                             0x52
#define GB_KEYPAD_1                             0x53
#define GB_KEYPAD_2                             0x54
#define GB_KEYPAD_3                             0x55
#define GB_KEYPAD_4                             0x56
#define GB_KEYPAD_5                             0x57
#define GB_KEYPAD_6                             0x58
#define GB_KEYPAD_7                             0x59
                                             /* 0x5a */
#define GB_KEYPAD_8                             0x5b
#define GB_KEYPAD_9                             0x5c
                                             /* 0x5d */
                                             /* 0x5e */
                                             /* 0x5f */
#define GB_KEYBOARD_F5                          0x60
#define GB_KEYBOARD_F6                          0x61
#define GB_KEYBOARD_F7                          0x62
#define GB_KEYBOARD_F3                          0x63
#define GB_KEYBOARD_F8                          0x64
                                             /* 0x65 */
                                             /* 0x66 */
                                             /* 0x67 */
                                             /* 0x68 */
#define GB_KEYBOARD_F13                         0x69
#define GB_KEYBOARD_F16                         0x6a
#define GB_KEYBOARD_F14                         0x6b
                                             /* 0x6c */
                                             /* 0x6d */
                                             /* 0x6e */
                                             /* 0x6f */
                                             /* 0x70 */
#define GB_KEYBOARD_F15                         0x71
#define GB_KEYBOARD_HELP                        0x72
#define GB_KEYBOARD_HOME                        0x73
#define GB_KEYBOARD_PAGE_UP                     0x74
#define GB_KEYBOARD_DELETE_FORWARD              0x75
#define GB_KEYBOARD_F4                          0x76
#define GB_KEYBOARD_END                         0x77
#define GB_KEYBOARD_F2                          0x78
#define GB_KEYBOARD_PAGE_DOWN                   0x79
#define GB_KEYBOARD_F1                          0x7a
#define GB_KEYBOARD_LEFT_ARROW                  0x7b
#define GB_KEYBOARD_RIGHT_ARROW                 0x7c
#define GB_KEYBOARD_DOWN_ARROW                  0x7d
#define GB_KEYBOARD_UP_ARROW                    0x7e
                                             /* 0x7f */

#if defined(__OBJC__)
// Slow, but perhaps useful.
extern NSString *GBKeyName(unsigned keyCode);
#endif

#endif
