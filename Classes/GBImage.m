#import <ApplicationServices/ApplicationServices.h>
#import <OpenGL/gl.h>

#import "GBImage.h"

static BOOL _findGLFormat(NSURL *url, CGImageRef image, unsigned *glInternalFormat, unsigned *glFormat, unsigned *glType)
{
    if (CGColorSpaceGetModel(CGImageGetColorSpace(image)) != kCGColorSpaceModelRGB)
    {
        NSLog(@"%@ is not in an RGB colorspace", url);
        return NO;
    }
    
    if (CGImageGetBitsPerComponent(image) != 8)
    {
        // TODO could support floating-point image formats
        NSLog(@"%@ is not 8 bits per channel", url);
        return NO;
    }
    
    if (CGImageGetBytesPerRow(image) % 4 != 0)
    {
        NSLog(@"%@ bytes per row is not a multiple of 4", url);
        return NO;
    }
        
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(image);
    if (alphaInfo == kCGImageAlphaPremultipliedLast)
    {
        alphaInfo = kCGImageAlphaLast;
        NSLog(@"Warning: %@ has premultiplied alpha", url);
    }
    if (alphaInfo == kCGImageAlphaPremultipliedFirst)
    {
        alphaInfo = kCGImageAlphaFirst;
        NSLog(@"Warning: %@ has premultiplied alpha", url);
    }
    if (alphaInfo == kCGImageAlphaOnly)
    {
        // TODO could support alpha-only image formats
        NSLog(@"%@ is alpha-only", url);
        return NO;
    }
    
    if (alphaInfo == kCGImageAlphaNone)
    {
        // 3 channels
        if (CGImageGetBytesPerRow(image) != 3 * CGImageGetWidth(image))
        {
            NSLog(@"%@ bytes per row is not 3 * width", url);
            return NO;
        }
        
        *glInternalFormat = GL_RGB;
        *glFormat = (CGImageGetBitmapInfo(image) & kCGBitmapByteOrderMask) == kCGBitmapByteOrder32Host
            ? GL_RGB
            : GL_BGR;
        *glType = GL_UNSIGNED_BYTE;
        return YES;
    }
    else
    {
        // 4 channels
        if (CGImageGetBytesPerRow(image) != 4 * CGImageGetWidth(image))
        {
            NSLog(@"%@ bytes per row is not4 * width", url);
            return NO;
        }
        
        unsigned type = (CGImageGetBitmapInfo(image) & kCGBitmapByteOrderMask) == kCGBitmapByteOrder32Host
            ? GL_UNSIGNED_INT_8_8_8_8_REV
            : GL_UNSIGNED_INT_8_8_8_8;
        unsigned antiType = type == GL_UNSIGNED_INT_8_8_8_8
            ? GL_UNSIGNED_INT_8_8_8_8_REV
            : GL_UNSIGNED_INT_8_8_8_8;

        switch (alphaInfo)
        {
        case kCGImageAlphaLast:
            *glInternalFormat = GL_RGBA;
            *glFormat         = GL_RGBA;
            *glType           = antiType;
            break;
            
        case kCGImageAlphaFirst:
            *glInternalFormat = GL_RGBA;
            *glFormat         = GL_BGRA;
            *glType           = type;
            break;
            
        case kCGImageAlphaNoneSkipLast:
            *glInternalFormat = GL_RGB;
            *glFormat         = GL_RGBA;
            *glType           = antiType;
            break;
            
        case kCGImageAlphaNoneSkipFirst:
            *glInternalFormat = GL_RGB;
            *glFormat         = GL_BGRA;
            *glType           = type;
            break;
            
        default:
            NSLog(@"%@ unknown alpha format", url);
            return NO;
        }
    
        return YES;
    }
}

@implementation GBImage

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (!self) return nil;
    
    // TODO could support DDS here easily enough...
    
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    if (!source)
    {
        [self dealloc];
        return nil;
    }
    
    CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    if (!image)
    {
        CFRelease(source);
        [self dealloc];
        return nil;
    }
    
    size = NSMakeSize(
        CGImageGetWidth(image),
        CGImageGetHeight(image));
    
    if (!_findGLFormat(url, image, &glInternalFormat, &glFormat, &glType))
    {
        CFRelease(image);
        CFRelease(source);
        [self dealloc];
        return nil;
    }
    
    data = (NSData *)CGDataProviderCopyData(CGImageGetDataProvider(image));
    if (!data)
    {
        CFRelease(image);
        CFRelease(source);
        [self dealloc];
        return nil;
    }
    
    return self;
}

+ (id)imageWithURL:(NSURL *)url
{
    return [[[self alloc] initWithURL:url] autorelease];
}

- (void)dealloc
{
    [data release];
    
    [super dealloc];
}

@synthesize size, glInternalFormat, glFormat, glType, data;

@end
