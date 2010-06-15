#import <Cocoa/Cocoa.h>

@class GBGLView;

@interface GBAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
    GBGLView *view;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet GBGLView *view;

- (IBAction)toggleFullScreen:(id)sender;

@end
