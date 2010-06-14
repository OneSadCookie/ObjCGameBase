#import <Cocoa/Cocoa.h>

@protocol GBGameDelegate;

@interface GBGLView : NSView
{
    NSOpenGLPixelFormat *pixelFormat;
    NSOpenGLContext     *context;
    
    id <GBGameDelegate>  delegate;
    
    BOOL firstFrame;
    
    double machTimeScale;
    double lastFrameTime;
    
    NSUInteger modifierFlags;
}

@property (readwrite, assign) IBOutlet id <GBGameDelegate> delegate;

@end
