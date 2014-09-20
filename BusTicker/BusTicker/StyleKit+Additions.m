//
//  StyleKit+Additions.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "StyleKit+Additions.h"

#define kFullWidth 512
#define kFullHeight 512

@interface StyleKitCache : NSCache
- (UIImage *)cachedImageForDrawing:(Drawing)drawing size:(CGSize)size;
- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing size:(CGSize)size;
@end

@implementation StyleKit (Additions)

+ (UIImage *)drawImage:(Drawing)drawing size:(CGSize)size {
    UIImage *image = [[self sh_sharedImageCache] cachedImageForDrawing:drawing size:size];
    if (image) {
        return image;
    }
    
    CGFloat scaleX = size.width / kFullHeight;
    CGFloat scaleY = size.height / kFullHeight;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);

    switch (drawing) {
        case DrawingDirections:
            [StyleKit drawDirectionsWithScaleX:scaleX scaleY:scaleY];
            break;
        case DrawingStarOff:
            [StyleKit drawStarWithScaleX:scaleX scaleY:scaleY starred:FALSE];
            break;
        case DrawingStarOn:
            [StyleKit drawStarWithScaleX:scaleX scaleY:scaleY starred:TRUE];
            break;
        case DrawingPicker:
            [StyleKit drawPickerWithScaleX:scaleX scaleY:scaleY];
            break;
            
        default:
            break;
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[self sh_sharedImageCache] cacheImage:image forDrawing:drawing size:size];
    
    return image;
}

#pragma mark - Caching
#pragma mark -

+ (StyleKitCache *)sh_sharedImageCache {
    static StyleKitCache *_sh_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sh_imageCache = [[StyleKitCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [_sh_imageCache removeAllObjects];
        }];
    });
    
    return _sh_imageCache;
}

@end

@implementation StyleKitCache

- (NSString *)keyForDrawing:(Drawing)drawing size:(CGSize)size;
{
    return [NSString stringWithFormat:@"drawing-%li-width-%f-height-%f", (long)drawing, size.width, size.height];
}

- (UIImage *)cachedImageForDrawing:(Drawing)drawing size:(CGSize)size;
{
    NSString *key = [self keyForDrawing:drawing size:size];
    return [self objectForKey:key];
}

- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing size:(CGSize)size;
{
    NSString *key = [self keyForDrawing:drawing size:size];
    if (!image || !key.length) {
        return;
    }
    [self setObject:image forKey:key];
}

@end