#include "revenge/platform_backend.h"
#include "revenge/audio.h"
#include "revenge/debug.h"
#include "revenge/input.h"
#include "revenge/original_data.h"
#include "revenge/video.h"

#include <SDL3/SDL.h>
#include <stdlib.h>
#include <string.h>

enum
{
    WindowScale = 0x03,
    RetracesPerSecond = 0x46,
    RetraceStatusBit = 0x08
};

static SDL_Window *window;
static SDL_Renderer *renderer;
static SDL_Texture *texture;
static byte indexedFramebuffer[VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT];
static uint32_t scanoutPixels[VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT];
static uint32_t logicalPalette[VGA_DAC_ENTRY_COUNT];
static byte currentVideoMode = 0x03;
static uint16 currentVideoAdapter = VIDEO_ADAPTER_EGA;
static uint64_t nextSpeakerEffectTick;
static uint64_t nextMIDIServiceTick;
static uint64_t nextGameClockTick;
static uint64_t nextDigitalPlaybackTick;
static uint64_t nextVideoPresentTick;
static byte previousMouseButtons;

enum
{
    SmokeInputCapacity = 0x80
};


typedef struct SmokeInputEvent
{
    uint32_t delayMilliseconds;
    uint16 rawKeypress;
} SmokeInputEvent;

static SmokeInputEvent smokeInputEvents[SmokeInputCapacity];
static uint16 smokeInputEventCount;
static uint16 smokeInputEventIndex;
static uint64_t smokeInputDueTime;
static byte smokeInputInitialized;

static void InitializeSmokeInput(void)
{
    const char *cursor;

    if (smokeInputInitialized != FALSE)
        return;
    smokeInputInitialized = TRUE;
    cursor = SDL_getenv("REVENGE_SMOKE_INPUT");
    while (cursor != NULL && *cursor != '\0' &&
        smokeInputEventCount < SmokeInputCapacity)
    {
        char *end;
        unsigned long delay = strtoul(cursor, &end, 0x0A);
        unsigned long key;

        if (end == cursor || *end != ':')
            break;
        cursor = end + 0x01;
        key = strtoul(cursor, &end, 0x10);
        if (end == cursor)
            break;
        smokeInputEvents[smokeInputEventCount].delayMilliseconds =
            (uint32_t)delay;
        smokeInputEvents[smokeInputEventCount].rawKeypress = (uint16)key;
        ++smokeInputEventCount;
        cursor = *end == ',' ? end + 0x01 : end;
    }
    if (smokeInputEventCount != 0x00)
        smokeInputDueTime = SDL_GetTicks() +
            smokeInputEvents[0x00].delayMilliseconds;
	RevengeTrace("input: smoke events=%u first-due=%llu\n",
		smokeInputEventCount, (unsigned long long) smokeInputDueTime);
}

static word16 SmokeInputPending(void)
{
    InitializeSmokeInput();
    return smokeInputEventIndex < smokeInputEventCount &&
        SDL_GetTicks() >= smokeInputDueTime;
}

static uint16 ReadSmokeInput(void)
{
    uint16 result = smokeInputEvents[smokeInputEventIndex].rawKeypress;
	RevengeTrace("input: smoke event=%u/%u key=%04X\n",
		smokeInputEventIndex + 0x01, smokeInputEventCount, result);
    ++smokeInputEventIndex;
    if (smokeInputEventIndex < smokeInputEventCount)
        smokeInputDueTime = SDL_GetTicks() +
            smokeInputEvents[smokeInputEventIndex].delayMilliseconds;
    return result;
}

void SDLBackend_ServiceTimers(void)
{
    const uint64_t speakerEffectPeriod =
        UINT64_C(60000000000) / 0x4440;
    const uint64_t midiServicePeriod =
        UINT64_C(60000000000) / 0x1110;
    const uint64_t gameClockPeriod =
        UINT64_C(1000000000) * 0x10000 / 0x1234DE;
    uint64_t now;

    now = SDL_GetTicksNS();
    if (DigitalSoundBusy != FALSE &&
        DigitalPlaybackRateHz != 0x0000)
    {
        const uint64_t digitalPlaybackPeriod = UINT64_C(1000000000) /
            DigitalPlaybackRateHz;

        if (nextDigitalPlaybackTick == 0x0000000000000000ULL)
            nextDigitalPlaybackTick = now;
        while (nextDigitalPlaybackTick <= now &&
            DigitalSoundBusy != FALSE)
        {
            /* DOS delivered the currently installed IRQ0 handler from the
             * programmable interval timer.  The hosted boundary performs
             * the same dispatch cooperatively. */
            SDLBackend_DispatchInstalledInterruptVector(0x08);
            nextDigitalPlaybackTick += digitalPlaybackPeriod;
        }
        if (DigitalSoundBusy == FALSE)
            nextDigitalPlaybackTick = 0x0000000000000000ULL;
    }
    else
    {
        nextDigitalPlaybackTick = 0x0000000000000000ULL;
    }
    while (nextSpeakerEffectTick <= now)
    {
        DecodePCSpeakerEffectTick();
        nextSpeakerEffectTick += speakerEffectPeriod;
    }
    while (nextMIDIServiceTick <= now)
    {
        ServiceMIDISequenceTick();
        nextMIDIServiceTick += midiServicePeriod;
    }
    while (nextGameClockTick <= now)
    {
        SDLBackend_DispatchInterrupt(0x1C);
        nextGameClockTick += gameClockPeriod;
    }
}

static void StoreRgba(uint32_t *pixel, byte red, byte green, byte blue)
{
    byte *components;

    components = (byte *)pixel;
    components[0x00] = red;
    components[0x01] = green;
    components[0x02] = blue;
    components[0x03] = 0xFF;
}

static void SetEgaColor(byte logicalColor, byte egaColor)
{
    byte red;
    byte green;
    byte blue;
    byte intensity;

    /* The game's 200-line EGA mode is displayed through an RGBI monitor.
       Attribute-controller bit 4 is the shared intensity signal; bits 3 and
       5 are not independent blue/red intensity channels in this mode. */
    intensity = (egaColor & 0x10) != 0 ? 0x55 : 0x00;
    red = (byte)(((egaColor & 0x04) != 0 ? 0xAA : 0x00) + intensity);
    green = (byte)(((egaColor & 0x02) != 0 ? 0xAA : 0x00) + intensity);
    blue = (byte)(((egaColor & 0x01) != 0 ? 0xAA : 0x00) + intensity);
    if ((egaColor & 0x17) == 0x06)
        green = 0x55;
    StoreRgba(&logicalPalette[logicalColor & 0x0F], red, green, blue);
}

static void ResetEgaPalette(void)
{
    static const byte defaultEgaColors[EGA_LOGICAL_PALETTE_ENTRY_COUNT] =
    {
        0x00, 0x01, 0x02, 0x03,
        0x04, 0x05, 0x14, 0x07,
        0x38, 0x39, 0x3A, 0x3B,
        0x3C, 0x3D, 0x3E, 0x3F
    };
    uint16 color;

    for (color = 0x0000; color < VGA_DAC_ENTRY_COUNT; ++color)
        StoreRgba(&logicalPalette[color], 0x00, 0x00, 0x00);
    for (color = 0x0000;
         color < EGA_LOGICAL_PALETTE_ENTRY_COUNT;
         ++color)
        SetEgaColor((byte)color, defaultEgaColors[color]);
}

static byte GetSet1ScanCode(SDL_Scancode scanCode)
{
    switch (scanCode)
    {
    case SDL_SCANCODE_ESCAPE: return 0x01;
    case SDL_SCANCODE_1: return 0x02;
    case SDL_SCANCODE_2: return 0x03;
    case SDL_SCANCODE_3: return 0x04;
    case SDL_SCANCODE_4: return 0x05;
    case SDL_SCANCODE_5: return 0x06;
    case SDL_SCANCODE_6: return 0x07;
    case SDL_SCANCODE_7: return 0x08;
    case SDL_SCANCODE_8: return 0x09;
    case SDL_SCANCODE_9: return 0x0A;
    case SDL_SCANCODE_0: return 0x0B;
    case SDL_SCANCODE_MINUS: return 0x0C;
    case SDL_SCANCODE_EQUALS: return 0x0D;
    case SDL_SCANCODE_BACKSPACE: return 0x0E;
    case SDL_SCANCODE_TAB: return 0x0F;
    case SDL_SCANCODE_Q: return 0x10;
    case SDL_SCANCODE_W: return 0x11;
    case SDL_SCANCODE_E: return 0x12;
    case SDL_SCANCODE_R: return 0x13;
    case SDL_SCANCODE_T: return 0x14;
    case SDL_SCANCODE_Y: return 0x15;
    case SDL_SCANCODE_U: return 0x16;
    case SDL_SCANCODE_I: return 0x17;
    case SDL_SCANCODE_O: return 0x18;
    case SDL_SCANCODE_P: return 0x19;
    case SDL_SCANCODE_LEFTBRACKET: return 0x1A;
    case SDL_SCANCODE_RIGHTBRACKET: return 0x1B;
    case SDL_SCANCODE_RETURN:
    case SDL_SCANCODE_KP_ENTER: return 0x1C;
    case SDL_SCANCODE_A: return 0x1E;
    case SDL_SCANCODE_S: return 0x1F;
    case SDL_SCANCODE_D: return 0x20;
    case SDL_SCANCODE_F: return 0x21;
    case SDL_SCANCODE_G: return 0x22;
    case SDL_SCANCODE_H: return 0x23;
    case SDL_SCANCODE_J: return 0x24;
    case SDL_SCANCODE_K: return 0x25;
    case SDL_SCANCODE_L: return 0x26;
    case SDL_SCANCODE_SEMICOLON: return 0x27;
    case SDL_SCANCODE_APOSTROPHE: return 0x28;
    case SDL_SCANCODE_GRAVE: return 0x29;
    case SDL_SCANCODE_BACKSLASH: return 0x2B;
    case SDL_SCANCODE_Z: return 0x2C;
    case SDL_SCANCODE_X: return 0x2D;
    case SDL_SCANCODE_C: return 0x2E;
    case SDL_SCANCODE_V: return 0x2F;
    case SDL_SCANCODE_B: return 0x30;
    case SDL_SCANCODE_N: return 0x31;
    case SDL_SCANCODE_M: return 0x32;
    case SDL_SCANCODE_COMMA: return 0x33;
    case SDL_SCANCODE_PERIOD: return 0x34;
    case SDL_SCANCODE_SLASH: return 0x35;
    case SDL_SCANCODE_SPACE: return 0x39;
    case SDL_SCANCODE_F1: return 0x3B;
    case SDL_SCANCODE_F2: return 0x3C;
    case SDL_SCANCODE_F3: return 0x3D;
    case SDL_SCANCODE_F4: return 0x3E;
    case SDL_SCANCODE_F5: return 0x3F;
    case SDL_SCANCODE_F6: return 0x40;
    case SDL_SCANCODE_F7: return 0x41;
    case SDL_SCANCODE_F8: return 0x42;
    case SDL_SCANCODE_F9: return 0x43;
    case SDL_SCANCODE_F10: return 0x44;
    case SDL_SCANCODE_HOME: return 0x47;
    case SDL_SCANCODE_UP: return 0x48;
    case SDL_SCANCODE_PAGEUP: return 0x49;
    case SDL_SCANCODE_LEFT: return 0x4B;
    case SDL_SCANCODE_RIGHT: return 0x4D;
    case SDL_SCANCODE_END: return 0x4F;
    case SDL_SCANCODE_DOWN: return 0x50;
    case SDL_SCANCODE_PAGEDOWN: return 0x51;
    case SDL_SCANCODE_DELETE: return 0x53;
    default: return 0x00;
    }
}

static byte TranslateScanCode(byte scanCode)
{
    static const byte scanCodeTranslation[0x59] =
    {
        0x7F, 0x6E, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0F, 0x10,
        0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
        0x19, 0x1A, 0x1B, 0x1C, 0x2B, 0x3A, 0x1F, 0x20,
        0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
        0x29, 0x01, 0x2C, 0x1D, 0x2E, 0x2F, 0x30, 0x31,
        0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x39, 0x64,
        0x3C, 0x3D, 0x1E, 0x70, 0x71, 0x72, 0x73, 0x74,
        0x75, 0x76, 0x77, 0x78, 0x79, 0x5A, 0x7D, 0x5B,
        0x60, 0x65, 0x69, 0x5C, 0x61, 0x66, 0x6A, 0x5D,
        0x62, 0x67, 0x63, 0x68, 0x7F, 0x7F, 0x7F, 0x7A,
        0x7B
    };

    if (scanCode >= sizeof(scanCodeTranslation))
        return 0x7F;
    return scanCodeTranslation[scanCode];
}

int SDLBackend_Open(void)
{
    if (window != 0)
    {
        RevengeTrace("video: open reused window=%p\n", (void *)window);
        return TRUE;
    }

    RevengeTrace("video: creating SDL window\n");

    if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_AUDIO))
        return FALSE;

    if (!SDL_CreateWindowAndRenderer(
        "BattleTech: The Crescent Hawks' Revenge",
        VIDEO_SCREEN_WIDTH * WindowScale,
        VIDEO_SCREEN_HEIGHT * WindowScale,
        SDL_WINDOW_RESIZABLE,
        &window,
        &renderer))
        goto failed;

    if (!SDL_SetRenderLogicalPresentation(
        renderer,
        VIDEO_SCREEN_WIDTH,
        VIDEO_SCREEN_HEIGHT,
        SDL_LOGICAL_PRESENTATION_LETTERBOX))
        goto failed;

    texture = SDL_CreateTexture(
        renderer,
        SDL_PIXELFORMAT_RGBA32,
        SDL_TEXTUREACCESS_STREAMING,
        VIDEO_SCREEN_WIDTH,
        VIDEO_SCREEN_HEIGHT);
    if (texture == 0 || !SDL_SetTextureScaleMode(texture, SDL_SCALEMODE_NEAREST))
        goto failed;

    ResetEgaPalette();
    memset(indexedFramebuffer, 0, sizeof(indexedFramebuffer));
    nextSpeakerEffectTick = SDL_GetTicksNS();
    nextMIDIServiceTick = nextSpeakerEffectTick;
    nextGameClockTick = nextSpeakerEffectTick;
    nextDigitalPlaybackTick = 0x0000000000000000ULL;
    previousMouseButtons = 0x00;
    if (!SDLBackend_OpenAudio())
        goto failed;
    RevengeTrace("video: SDL window ready window=%p renderer=%p\n",
        (void *)window, (void *)renderer);
    return TRUE;

failed:
    SDLBackend_Close();
    return FALSE;
}

void SDLBackend_Close(void)
{
    RevengeTrace("video: closing SDL window=%p\n", (void *)window);
    SDLBackend_CloseAudio();
    SDL_DestroyTexture(texture);
    texture = 0;
    SDL_DestroyRenderer(renderer);
    renderer = 0;
    SDL_DestroyWindow(window);
    window = 0;
    SDL_QuitSubSystem(SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_AUDIO);
}

int SDLBackend_PollQuit(void)
{
    SDL_Event event;

    SDL_PumpEvents();
    return SDL_PeepEvents(
        &event,
        0x01,
        SDL_GETEVENT,
        SDL_EVENT_QUIT,
        SDL_EVENT_QUIT) > 0x00;
}

uint64_t SDLBackend_Milliseconds(void)
{
    return SDL_GetTicks();
}

void SDLBackend_Delay(uint32_t milliseconds)
{
    SDL_Delay(milliseconds);
}

byte SDLBackend_GetVideoMode(void)
{
    return currentVideoMode;
}

void SDLBackend_SetVideoMode(byte videoMode)
{
    currentVideoMode = videoMode;
    if (videoMode != 0x03 && window == 0)
        (void)SDLBackend_Open();
}

void SDLBackend_SetVideoAdapter(uint16 adapterType)
{
    currentVideoAdapter = adapterType;
    (void)currentVideoAdapter;
}

void SDLBackend_SelectCgaPalette(byte paletteId)
{
    static const byte cgaPalette0[0x03] = { 0x02, 0x04, 0x06 };
    static const byte cgaPalette1[0x03] = { 0x03, 0x05, 0x07 };
    const byte *palette;

    palette = paletteId == 0x00 ? cgaPalette0 : cgaPalette1;
    SetEgaColor(0x01, palette[0x00]);
    SetEgaColor(0x02, palette[0x01]);
    SetEgaColor(0x03, palette[0x02]);
}

void SDLBackend_SetPaletteRegister(byte paletteRegister, byte paletteValue)
{
    if (paletteRegister < EGA_LOGICAL_PALETTE_ENTRY_COUNT)
        SetEgaColor(paletteRegister, paletteValue);
}

void SDLBackend_SetEgaGraphicsControllerRegister(byte registerIndex, byte value)
{
    /* The indexed host framebuffer does not expose EGA latches or planes.
       Keep the original controller write at this lowest hardware boundary. */
    (void)registerIndex;
    (void)value;
}

void SDLBackend_SetEgaSequencerRegister(byte registerIndex, byte value)
{
	/* As with the graphics controller, planar write selection terminates at
	   this hardware boundary when the host uses an indexed framebuffer. */
	(void)registerIndex;
	(void)value;
}

void SDLBackend_LoadVgaPalette(const byte *paletteRgbTriplets)
{
    uint16 paletteIndex;

    if (paletteRgbTriplets == 0)
        return;
    for (paletteIndex = 0x0000;
         paletteIndex < VGA_DAC_ENTRY_COUNT;
         ++paletteIndex)
    {
        const byte *source;
        byte red;
        byte green;
        byte blue;

        source = paletteRgbTriplets + paletteIndex * 0x03;
        red = (byte)((source[0x00] << 0x02) | (source[0x00] >> 0x04));
        green = (byte)((source[0x01] << 0x02) | (source[0x01] >> 0x04));
        blue = (byte)((source[0x02] << 0x02) | (source[0x02] >> 0x04));
        StoreRgba(&logicalPalette[paletteIndex], red, green, blue);
    }
}

uint16 SDLBackend_IsVerticalRetraceActive(void)
{
    uint64_t period;
    uint64_t phase;

    period = UINT64_C(1000000000) / RetracesPerSecond;
    phase = SDL_GetTicksNS() % period;
    return phase >= period - period / 0x0A ? RetraceStatusBit : 0x0000;
}

void SDLBackend_WaitVerticalRetrace(byte waitForRetraceStart)
{
    uint64_t delay;
    uint64_t now;
    uint64_t period;
    uint64_t phase;
    uint64_t retraceStart;

    SDLBackend_ServiceTimers();
    period = UINT64_C(1000000000) / RetracesPerSecond;
    now = SDL_GetTicksNS();
    phase = now % period;
    retraceStart = period - period / 0x0A;

    if (waitForRetraceStart == VERTICAL_RETRACE_WAIT_FOR_START)
    {
        if (phase < retraceStart)
            delay = retraceStart - phase;
        else
            delay = period - phase + retraceStart;
    }
    else
    {
        /* The original waits for retrace to begin and then end, so even an
         * invocation during active display targets the next period boundary. */
        delay = period - phase;
    }

    SDL_DelayNS(delay);
    (void)SDLBackend_PresentIndexedFramebuffer();
}

byte *SDLBackend_GetIndexedFramebuffer(void)
{
    return indexedFramebuffer;
}

void SDLBackend_ClearIndexedFramebuffer(byte color)
{
    memset(indexedFramebuffer, color, sizeof(indexedFramebuffer));
}

void SDLBackend_DrawIndexedPixel(uint16 x, uint16 y, byte color)
{
    if (x < VIDEO_SCREEN_WIDTH && y < VIDEO_SCREEN_HEIGHT)
        indexedFramebuffer[(uint32_t)y * VIDEO_SCREEN_WIDTH + x] = color;
}

int SDLBackend_PresentIndexedFramebuffer(void)
{
    uint32_t pixelIndex;

    if (texture == 0 || renderer == 0)
        return FALSE;

    for (pixelIndex = 0x00000000;
         pixelIndex < VIDEO_SCREEN_WIDTH * VIDEO_SCREEN_HEIGHT;
         ++pixelIndex)
    {
        scanoutPixels[pixelIndex] =
            logicalPalette[indexedFramebuffer[pixelIndex]];
    }

    return SDL_UpdateTexture(
        texture,
        0,
        scanoutPixels,
        VIDEO_SCREEN_WIDTH * sizeof(uint32_t))
        && SDL_RenderClear(renderer)
        && SDL_RenderTexture(renderer, texture, 0, 0)
        && SDL_RenderPresent(renderer);
}

void Video_PresentTransientFrame(void)
{
    /* DOS effects become visible as soon as their pixels reach A000h.  SDL
     * has an explicit scanout stage, so publish the complete tactical-effect
     * frame before the preserved redraw overwrites it.  One VGA scan period
     * also prevents the much faster host loop from consuming every animation
     * frame between two visible refreshes. */
    (void)SDLBackend_PresentIndexedFramebuffer();
    SDL_DelayNS(UINT64_C(1000000000) / RetracesPerSecond);
}

static void PresentPendingVideoFrame(void)
{
    const uint64_t videoPresentPeriod = UINT64_C(1000000000) / 0x3C;
    uint64_t now;

    now = SDL_GetTicksNS();
    if (now < nextVideoPresentTick)
        return;

    (void)SDLBackend_PresentIndexedFramebuffer();
    nextVideoPresentTick = now + videoPresentPeriod;
}

word16 SDLBackend_InputPending(void)
{
    SDL_Event event;

    /* DOS tested the keyboard controller without waiting.  Sleeping here
       turns the preserved queue-drain loops into multi-second stalls when a
       held key has generated repeat make codes. */
    SDLBackend_ServiceTimers();
    PresentPendingVideoFrame();
    if (SmokeInputPending() != FALSE)
        return 0x00FF;
    SDL_PumpEvents();
    if (SDL_PeepEvents(
        &event,
        0x01,
        SDL_PEEKEVENT,
        SDL_EVENT_QUIT,
        SDL_EVENT_QUIT) > 0x00)
        return 0x00FF;
    if (SDL_PeepEvents(
        &event,
        0x01,
        SDL_PEEKEVENT,
        SDL_EVENT_KEY_DOWN,
        SDL_EVENT_KEY_DOWN) > 0x00)
        return 0x00FF;
    return 0x0000;
}

uint16 SDLBackend_ReadRawKeypress(void)
{
    SDL_Event event;
    byte scanCode;
    byte keyId;
    byte modifierFlags;

    for (;;)
    {
        SDLBackend_ServiceTimers();
        PresentPendingVideoFrame();
        if (SmokeInputPending() != FALSE)
            return ReadSmokeInput();
        if (!SDL_WaitEventTimeout(&event, 0x08))
            continue;
        if (event.type == SDL_EVENT_QUIT)
            return 0x006E;
		if (event.type == SDL_EVENT_KEY_UP)
			continue;
        if (event.type != SDL_EVENT_KEY_DOWN)
            continue;

		/* SDL repeat key-down events are the host equivalent of the repeated
		 * make codes generated by the original PC keyboard controller. */
        scanCode = GetSet1ScanCode(event.key.scancode);
        if (scanCode == 0x00)
            continue;

        keyId = TranslateScanCode(scanCode);
		RevengeTrace("input: key scancode=%02X key=%02X repeat=%u\n",
			scanCode, keyId, event.key.repeat ? 0x01 : 0x00);
        modifierFlags = 0x00;
        if ((event.key.mod & SDL_KMOD_SHIFT) != 0)
            modifierFlags |= 0x01;
        if ((event.key.mod & SDL_KMOD_CTRL) != 0)
            modifierFlags |= 0x02;
        if ((event.key.mod & SDL_KMOD_ALT) != 0)
            modifierFlags |= 0x04;
        return ((uint16)modifierFlags << 0x08) | keyId;
    }
}

void SDLBackend_InstallKeyboardHandlers(void)
{
    SDL_FlushEvents(SDL_EVENT_KEY_DOWN, SDL_EVENT_KEY_UP);
}

void SDLBackend_RestoreKeyboardHandlers(void)
{
    SDL_FlushEvents(SDL_EVENT_KEY_DOWN, SDL_EVENT_KEY_UP);
}

void ReadMouseInputState(MouseInputState *state)
{
    float windowX;
    float windowY;
    float logicalX;
    float logicalY;
    SDL_MouseButtonFlags hostButtons;
    byte buttons;

    if (state == NULL)
        return;
    SDL_PumpEvents();
    hostButtons = SDL_GetMouseState(&windowX, &windowY);
    logicalX = windowX;
    logicalY = windowY;
    if (renderer != NULL)
        (void)SDL_RenderCoordinatesFromWindow(
            renderer, windowX, windowY, &logicalX, &logicalY);
    if (logicalX < 0.0f)
        logicalX = 0.0f;
    if (logicalY < 0.0f)
        logicalY = 0.0f;
    if (logicalX >= VIDEO_SCREEN_WIDTH)
        logicalX = VIDEO_SCREEN_WIDTH - 0x01;
    if (logicalY >= VIDEO_SCREEN_HEIGHT)
        logicalY = VIDEO_SCREEN_HEIGHT - 0x01;

    buttons = 0x00;
    if ((hostButtons & SDL_BUTTON_LMASK) != 0x00)
        buttons |= MOUSE_BUTTON_LEFT;
    if ((hostButtons & SDL_BUTTON_RMASK) != 0x00)
        buttons |= MOUSE_BUTTON_RIGHT;
    state->x = (uint16)logicalX;
    state->y = (uint16)logicalY;
    state->buttonState = buttons;
    state->buttonEvent = (byte)((buttons & (byte)~previousMouseButtons)
        != 0x00);
    previousMouseButtons = buttons;
}

void SDLBackend_SetMouseVisible(uint16 visible)
{
    if (visible != FALSE)
        (void)SDL_ShowCursor();
    else
        (void)SDL_HideCursor();
}

void SDLBackend_SetMousePosition(int16 logicalX, int16 logicalY)
{
    float windowX;
    float windowY;

    if (window == NULL)
        return;
    windowX = (float)logicalX;
    windowY = (float)logicalY;
    if (renderer != NULL)
    {
        (void)SDL_RenderCoordinatesToWindow(
            renderer, windowX, windowY, &windowX, &windowY);
    }
    SDL_WarpMouseInWindow(window, windowX, windowY);
}
