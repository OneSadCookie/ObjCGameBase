#import <OpenGL/gl.h>

#import "GBImage.h"
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

- (void)gameDidLoad
{
    image = [[GBImage alloc] initWithURL:[NSURL fileURLWithPath:@"/Library/User Pictures/Nature/Lightning.tif"]];
    if (!image) abort();
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_RECTANGLE_ARB, texture);
    glTexParameteri(GL_TEXTURE_RECTANGLE_ARB, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_RECTANGLE_ARB, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_RECTANGLE_ARB, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_RECTANGLE_ARB, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexImage2D(
        GL_TEXTURE_RECTANGLE_ARB,
        0,
        [image glInternalFormat],
        [image size].width,
        [image size].height,
        0,
        [image glFormat],
        [image glType],
        [[image data] bytes]);
    [image releaseImageData];
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
    float x_offset = 1.0f / (((float)size.width) / ((float)[image size].width));
	float y_offset = 1.0f / (((float)size.height) / ((float)[image size].height));
    glEnable(GL_TEXTURE_RECTANGLE_ARB);
    glBegin(GL_QUADS);
        glTexCoord2f(0, [image size].height);
        glVertex2f(-x_offset, -y_offset);
        glTexCoord2f([image size].width, [image size].height);
        glVertex2f( x_offset, -y_offset);
        glTexCoord2f([image size].width, 0);
        glVertex2f( x_offset,  y_offset);
        glTexCoord2f(0, 0);
        glVertex2f(-x_offset,  y_offset);
    glEnd();
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
