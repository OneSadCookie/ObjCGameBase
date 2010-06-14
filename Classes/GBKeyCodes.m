#import <Carbon/Carbon.h>

#import "GBKeyCodes.h"

static NSString *_fallbackTable[128] =
{
    /* 00 */ @"A",
    /* 01 */ @"S",
    /* 02 */ @"D",
    /* 03 */ @"F",
    /* 04 */ @"H",
    /* 05 */ @"G",
    /* 06 */ @"Z",
    /* 07 */ @"X",
    /* 08 */ @"C",
    /* 09 */ @"V",
    /* 0a */ nil,
    /* 0b */ @"B",
    /* 0c */ @"Q",
    /* 0d */ @"W",
    /* 0e */ @"E",
    /* 0f */ @"R",
    /* 10 */ @"Y",
    /* 11 */ @"T",
    /* 12 */ @"1",
    /* 13 */ @"2",
    /* 14 */ @"3",
    /* 15 */ @"4",
    /* 16 */ @"6",
    /* 17 */ @"5",
    /* 18 */ @"Keypad =",
    /* 19 */ @"9",
    /* 1a */ @"7",
    /* 1b */ @"-",
    /* 1c */ @"8",
    /* 1d */ @"0",
    /* 1e */ @")",
    /* 1f */ @"O",
    /* 20 */ @"U",
    /* 21 */ @"(",
    /* 22 */ @"I",
    /* 23 */ @"P",
    /* 24 */ @"Return",
    /* 25 */ @"L",
    /* 26 */ @"J",
    /* 27 */ @"'",
    /* 28 */ @"K",
    /* 29 */ @";",
    /* 2a */ @"\\",
    /* 2b */ @",",
    /* 2c */ @"/",
    /* 2d */ @"N",
    /* 2e */ @"M",
    /* 2f */ @".",
    /* 30 */ @"Tab",
    /* 31 */ @"Space",
    /* 32 */ @"`",
    /* 33 */ @"Delete",
    /* 34 */ nil,
    /* 35 */ @"Esc",
    /* 36 */ @"Right Command",
    /* 37 */ @"Left Command",
    /* 38 */ @"Left Shift",
    /* 39 */ nil,
    /* 3a */ @"Left Option",
    /* 3b */ @"Left Control",
    /* 3c */ @"Right Shift",
    /* 3d */ @"Right Option",
    /* 3e */ @"Right Control",
    /* 3f */ nil,
    /* 40 */ @"F17",
    /* 41 */ @"Keypad .",
    /* 42 */ nil,
    /* 43 */ @"Keypad *",
    /* 44 */ nil,
    /* 45 */ @"Keypad +",
    /* 46 */ nil,
    /* 47 */ nil,
    /* 48 */ nil,
    /* 49 */ nil,
    /* 4a */ nil,
    /* 4b */ @"Keypad /",
    /* 4c */ @"Keypad Enter",
    /* 4d */ nil,
    /* 4e */ @"Keypad -",
    /* 4f */ @"F18",
    /* 50 */ @"F19",
    /* 51 */ nil,
    /* 52 */ @"Keypad 0",
    /* 53 */ @"Keypad 1",
    /* 54 */ @"Keypad 2",
    /* 55 */ @"Keypad 3",
    /* 56 */ @"Keypad 4",
    /* 57 */ @"Keypad 5",
    /* 58 */ @"Keypad 6",
    /* 59 */ @"Keypad 7",
    /* 5a */ nil,
    /* 5b */ @"Keypad 8",
    /* 5c */ @"Keypad 9",
    /* 5d */ nil,
    /* 5e */ nil,
    /* 5f */ nil,
    /* 60 */ @"F5",
    /* 61 */ @"F6",
    /* 62 */ @"F7",
    /* 63 */ @"F3",
    /* 64 */ @"F8",
    /* 65 */ nil,
    /* 66 */ nil,
    /* 67 */ nil,
    /* 68 */ nil,
    /* 69 */ @"F13",
    /* 6a */ @"F16",
    /* 6b */ @"F14",
    /* 6c */ nil,
    /* 6d */ nil,
    /* 6e */ nil,
    /* 6f */ nil,
    /* 70 */ nil,
    /* 71 */ @"F15",
    /* 72 */ @"Help",
    /* 73 */ @"Home",
    /* 74 */ @"Page Up",
    /* 75 */ @"Forward Delete", // TODO delete symbol?
    /* 76 */ @"F4",
    /* 77 */ @"End",
    /* 78 */ @"F2",
    /* 79 */ @"Page Down",
    /* 7a */ @"F1",
    /* 7b */ @"Left Arrow", // TODO arrow symbols?
    /* 7c */ @"Right Arrow",
    /* 7d */ @"Down Arrow",
    /* 7e */ @"Up Arrow",
    /* 7f */ nil,
};

// FIXME this is really dubious.  Surely there must be a way to have the OS
// provide this info reliably?
NSString *_fallbackGBKeyName(unsigned keyCode)
{
    return keyCode < 128 && _fallbackTable[keyCode]
        ? _fallbackTable[keyCode]
        : [NSString stringWithFormat:@"Key #%u", keyCode];
}

NSString *GBKeyName(unsigned keyCode)
{
    TISInputSourceRef inputSource = TISCopyCurrentKeyboardLayoutInputSource();
    if (!inputSource)
    {
        // NSLog(@"no current keyboard layout input source, falling back");
        return _fallbackGBKeyName(keyCode);
    }    
    NSData *uchr = TISGetInputSourceProperty(
        inputSource,
        kTISPropertyUnicodeKeyLayoutData);
    if (!uchr)
    {
        // NSLog(@"no uchr data for input source, falling back");
        CFRelease(inputSource);
        return _fallbackGBKeyName(keyCode);
    }
    
    UInt32 deadKeys = 0;
    UniChar buffer[8];
    UniCharCount actualStringLength = 0;
    OSStatus err = UCKeyTranslate(
        [uchr bytes],
        keyCode,
        kUCKeyActionDisplay,
        0, // modifier flags
        LMGetKbdType(),
        kUCKeyTranslateNoDeadKeysBit,
        &deadKeys,
        8, // length of buffer
        &actualStringLength,
        buffer);
    if (err != noErr)
    {
        // NSLog(@"error %d in UCKeyTranslate, falling back", err);
        return _fallbackGBKeyName(keyCode);
    }
    
    // FIXME isprint is not unicode-aware...
    if (actualStringLength == 0 || (actualStringLength == 1 && !isprint(buffer[0])))
    {
        // NSLog(@"zero-length result of UCKeyTranslate, falling back");
        return _fallbackGBKeyName(keyCode);
    }
    
    NSLog(@"0x%04x", buffer[0]);
    return [[NSString stringWithCharacters:buffer length:actualStringLength] uppercaseString];
}
