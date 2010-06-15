#import "GBGameDelegate.h"

@class GBImage;

@interface MyGameDelegate : NSObject <GBGameDelegate>
{
    GBImage *image;
    unsigned texture;
}

@end
