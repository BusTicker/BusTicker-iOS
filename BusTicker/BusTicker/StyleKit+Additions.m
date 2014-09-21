//
//  StyleKit+Additions.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "StyleKit+Additions.h"

#import "AppHelper.h"

#define kFullWidth 512
#define kFullHeight 512

@interface StyleKitCache : NSCache

- (NSString *)keyForDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
- (NSString *)keyForDrawing:(Drawing)drawing scale:(CGFloat)scale;

- (UIImage *)cachedImageForKey:(NSString *)key;
- (UIImage *)cachedImageForDrawing:(Drawing)drawing scale:(CGFloat)scale;
- (UIImage *)cachedImageForDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
- (void)cacheImage:(UIImage *)image
            forKey:(NSString *)key;
- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing scale:(CGFloat)scale;
- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
@end

@implementation StyleKit (Additions)

+ (UIImage *)drawImage:(Drawing)drawing size:(CGSize)size;
{
    CGFloat scale = roundf(size.height / kFullHeight * 100.0f);
    
    UIImage *image = [[self sh_sharedImageCache] cachedImageForDrawing:drawing scale:scale];
    if (image) {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);

    switch (drawing) {
        case DrawingDirections:
            [StyleKit drawDirectionsWithScale:scale];
            break;
        case DrawingBusStop:
            [StyleKit drawBusStopWithScale:scale];
            break;
        case DrawingForecast:
            [StyleKit drawForecastWithScale:scale];
            break;
        case DrawingStarOff:
            [StyleKit drawStarWithStarred:FALSE scale:scale];
            break;
        case DrawingStarOn:
            [StyleKit drawStarWithStarred:TRUE scale:scale];
            break;
        case DrawingPicker:
            [StyleKit drawPickerWithScale:scale];
            break;
            
        default:
            MAAssert(FALSE, @"Drawing not supported");
            break;
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[self sh_sharedImageCache] cacheImage:image forDrawing:drawing  scale:scale];
    
    return image;
}

+ (UIImage *)drawEstimateCircleImageWithCircleScale:(CGFloat)circleScale imageSize:(CGSize)imageSize;
{
    CGFloat scale = roundf(imageSize.height / kFullHeight * 100.0f);
    
    UIImage *image = [[self sh_sharedImageCache] cachedImageForDrawing:DrawingEstimateCircle circleScale:circleScale scale:scale];
    if (image) {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    
    [StyleKit drawEstimateCircleWithCircleScale:circleScale * 100.0f scale:scale];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[self sh_sharedImageCache] cacheImage:image forDrawing:DrawingEstimateCircle circleScale:circleScale scale:scale];
    
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

- (NSString *)keyForDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
{
    return [NSString stringWithFormat:@"drawing-%li-circleScale-%f-scale-%f", (long)drawing, circleScale, scale];
}

- (NSString *)keyForDrawing:(Drawing)drawing scale:(CGFloat)scale;
{
    return [NSString stringWithFormat:@"drawing-%li-scale-%f", (long)drawing, scale];
}

- (UIImage *)cachedImageForKey:(NSString *)key;
{
    return [self objectForKey:key];
}

- (UIImage *)cachedImageForDrawing:(Drawing)drawing scale:(CGFloat)scale;
{
    NSString *key = [self keyForDrawing:drawing scale:scale];
    return [self cachedImageForKey:key];
}

- (UIImage *)cachedImageForDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
{
    NSString *key = [self keyForDrawing:drawing circleScale:circleScale scale:scale];
    return [self cachedImageForKey:key];
}

- (void)cacheImage:(UIImage *)image
            forKey:(NSString *)key;
{
    if (!key.length) {
        return;
    }
    else if (!image) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:image forKey:key];
    }
}

- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing scale:(CGFloat)scale;
{
    NSString *key = [self keyForDrawing:drawing scale:scale];
    [self cacheImage:image forKey:key];
}

- (void)cacheImage:(UIImage *)image
        forDrawing:(Drawing)drawing circleScale:(CGFloat)circleScale scale:(CGFloat)scale;
{
    NSString *key = [self keyForDrawing:drawing circleScale:circleScale scale:scale];
    [self cacheImage:image forKey:key];
}

@end