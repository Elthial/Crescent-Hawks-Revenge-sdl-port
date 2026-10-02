#include "fake_backend.h"
#include "revenge/input.h"

#include <assert.h>

static void ExpectTranslation(uint16 rawKeypress, int16 translated)
{
    fakeBackend.rawKeypress = rawKeypress;
    fakeBackend.inputPending = TRUE;
    assert((int16)(int8_t)TranslateKeyCode() == translated);
}

int main(void)
{
    FakeBackend_Reset();

    fakeBackend.rawKeypress = 0x0020;
    fakeBackend.inputPending = TRUE;
    assert(KeyboardInputPending() == 0x0002);
    assert(ReadRawKeypress() == 0x0020);

    ExpectTranslation(0x0020, 's');
    ExpectTranslation(0x0120, 'S');
    ExpectTranslation(0x0220, 0x0013);
    ExpectTranslation(0x006E, KEY_ESCAPE);
    ExpectTranslation(0x0070, -0x003B);
    ExpectTranslation(0x005C, -0x004B);

    fakeBackend.interruptVectors[0x09] = 0xAAAA1111;
    fakeBackend.interruptVectors[0x23] = 0xBBBB2222;
    InstallKeyboardHandlers();
    assert(fakeBackend.interruptVectors[0x09] == 0x30370510);
    assert(fakeBackend.interruptVectors[0x23] == 0x30370762);
    RestoreKeyboardHandlers();
    assert(fakeBackend.interruptVectors[0x09] == 0xAAAA1111);
    assert(fakeBackend.interruptVectors[0x23] == 0xBBBB2222);

    return 0x00;
}
