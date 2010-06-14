#import <mach/mach_time.h>

#import "GBGameDelegate.h"
#import "GBGLView.h"

static NSOpenGLPixelFormatAttribute GBGLAttributes[] =
{
    NSOpenGLPFADoubleBuffer,
    0
};


@interface GBGLView ()

@property (readwrite, retain) NSOpenGLPixelFormat *pixelFormat;
@property (readwrite, retain) NSOpenGLContext     *context;

@end


@implementation GBGLView

@synthesize pixelFormat;
@synthesize context;

@synthesize delegate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:GBGLAttributes];
    if (!self.pixelFormat) { [self dealloc]; return nil; }
    
    self.context = [[NSOpenGLContext alloc] initWithFormat:self.pixelFormat shareContext:nil];
    if (!self.context) { [self dealloc]; return nil; }
    
    GLint sync = 1;
    [self.context setValues:&sync forParameter:NSOpenGLCPSwapInterval];
    
    firstFrame = YES;
    
    return self;
}

- (void)dealloc
{
    [self.pixelFormat release];
    [self.context release];
    
    [super dealloc];
}

- (BOOL)isOpaque
{
    return YES;
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)doOneFrame
{
    if (firstFrame)
    {
        struct mach_timebase_info timebase;
        mach_timebase_info(&timebase);
        machTimeScale = 0.000000001 * ((double)timebase.numer / (double)timebase.denom);
        lastFrameTime = (double)mach_absolute_time() * machTimeScale;
    
        if ([NSEvent respondsToSelector:@selector(modifierFlags)])
        {
            modifierFlags = [NSEvent modifierFlags];
        }
        
        [self.context setView:self];
        
        [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(doOneFrame) userInfo:nil repeats:YES];
        
        firstFrame = NO;
    }
    
    double now = (double)mach_absolute_time() * machTimeScale;
    
    [self.delegate update:now - lastFrameTime];
    lastFrameTime = now;

    [self.context makeCurrentContext];
    [self.delegate drawAtSize:[self bounds].size];
    [self.context flushBuffer];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self doOneFrame];
}

- (void)keyDown:(NSEvent *)e
{
    [self.delegate keyDown:[e keyCode]];
}

- (void)keyUp:(NSEvent *)e
{
    [self.delegate keyUp:[e keyCode]];
}

- (void)flagsChanged:(NSEvent *)e
{
    NSUInteger flags = [e modifierFlags];
    if (flags > modifierFlags)
    {
        [self.delegate keyDown:[e keyCode]];
    }
    else
    {
        [self.delegate keyUp:[e keyCode]];
    }
    modifierFlags = flags;
}

@end
