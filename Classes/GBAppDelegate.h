#import <Cocoa/Cocoa.h>

@class GBGLView;

@interface GBAppDelegate : NSObject
{
    NSWindow *window;
    GBGLView *view;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet GBGLView *view;

- (IBAction)toggleFullScreen:(id)sender;

@end
