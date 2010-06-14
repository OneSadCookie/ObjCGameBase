#import <OpenGL/gl.h>

#import "GBKeyCodes.h"

#import "MyGameDelegate.h"

@implementation MyGameDelegate

- (id)init
{
    self = [super init];
    if (!self) return self;
    
    return self;
}

- (void)dealloc
{
    // Clean-up code here.
    
    [super dealloc];
}

- (void)update:(double)dt
{
    static int frames = 0;
    frames++;
    static double seconds = 0.0;
    seconds += dt;
    if (seconds > 1.0)
    {
        NSLog(@"%0.2f FPS", frames / seconds);
        frames = 0;
        seconds = 0.0;
    }
}

- (void)drawAtSize:(NSSize)size
{
    glViewport(0, 0, size.width, size.height);
    glClear(GL_COLOR_BUFFER_BIT);
}

- (void)keyDown:(unsigned)keyCode
{
    NSLog(@"%@ down", GBKeyName(keyCode));
}

- (void)keyUp:(unsigned)keyCode
{
    NSLog(@"%@ up", GBKeyName(keyCode));
}

@end
