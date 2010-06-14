#import "GBAppDelegate.h"
#import "GBGLView.h"

@implementation GBAppDelegate

@synthesize window;
@synthesize view;

- (void)applicationWillFinishLaunching:(NSNotification *)note
{
    [self.window setAspectRatio:NSMakeSize(8, 5)];
    [self.window center];
}

- (IBAction)toggleFullScreen:(id)sender
{
    if ([self.view isInFullScreenMode])
    {
        [self.view exitFullScreenModeWithOptions:nil];
    }
    else
    {
        [self.view enterFullScreenMode:[self.window screen] withOptions:nil];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app
{
    return YES;
}

@end
