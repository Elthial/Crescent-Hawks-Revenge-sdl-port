#ifndef REVENGE_INPUT_H
#define REVENGE_INPUT_H

#include "revenge/types.h"

enum
{
    KEY_BACKSPACE = 0x08,
    KEY_TAB = 0x09,
    KEY_CARRIAGE_RETURN = 0x0D,
    KEY_CTRL_S = 0x13,
    KEY_ESCAPE = 0x1B,
    KEY_SPACE = 0x20,
    KEY_ONE = 0x31,
    KEY_TWO = 0x32,
    KEY_THREE = 0x33,
    KEY_FOUR = 0x34,
    KEY_SIX = 0x36,
    KEY_SEVEN = 0x37,
    KEY_EIGHT = 0x38,
    KEY_NINE = 0x39,
    KEY_DELETE = 0xAD,
    KEY_PAGE_DOWN = 0xAF,
    KEY_DOWN = 0xB0,
    KEY_END = 0xB1,
    KEY_RIGHT = 0xB3,
    KEY_LEFT = 0xB5,
    KEY_PAGE_UP = 0xB7,
    KEY_UP = 0xB8,
    KEY_HOME = 0xB9,
    KEY_F10 = 0xBC,
    KEY_F9 = 0xBD,
    KEY_F8 = 0xBE,
    KEY_F7 = 0xBF,
    KEY_F6 = 0xC0,
    KEY_F5 = 0xC1,
    KEY_F4 = 0xC2,
    KEY_F3 = 0xC3,
    KEY_F2 = 0xC4,
    KEY_F1 = 0xC5,
    MOUSE_BUTTON_LEFT = 0x01,
    MOUSE_BUTTON_RIGHT = 0x02
};

typedef struct MouseInputState
{
    uint16 x;
    uint16 y;
    byte buttonState;
    byte buttonEvent;
} MouseInputState;

static inline int16 TranslatedExtendedKey(byte keyCode)
{
    return (int16)(int8_t)keyCode;
}

word16 KeyboardInputPending(void);
uint16 ReadRawKeypress(void);
int8 TranslateKeyCode(void);
int16 ReadTranslatedKeypress(void);
word16 WaitForDismissInput(void);
word16 WaitForKeyboardOrMouseInput(void);
void FlushPendingInput(void);
void InstallKeyboardHandlers(void);
void RestoreKeyboardHandlers(void);
void ReadMouseInputState(MouseInputState *state);
void ServiceMouseInputCallback(void);

#endif
