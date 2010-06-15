#import <Foundation/Foundation.h>

@interface GBImage : NSObject
{
    NSSize      size;
    unsigned    glInternalFormat;
    unsigned    glFormat;
    unsigned    glType;
    NSData     *data;
}

- (id)initWithURL:(NSURL *)url;

+ (id)imageWithURL:(NSURL *)url;

@property (readonly) NSSize      size;
@property (readonly) unsigned    glInternalFormat;
@property (readonly) unsigned    glFormat;
@property (readonly) unsigned    glType;
@property (readonly) NSData     *data;

@end
