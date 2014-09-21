//
//  StyleKit+Additions.h
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StyleKit.h"

typedef enum {
    DrawingNone = 0,
    DrawingDirections,
    DrawingStarOff,
    DrawingStarOn,
    DrawingPicker,
    DrawingEstimateCircle
} Drawing;

@interface StyleKit (Additions)

+ (UIImage *)drawImage:(Drawing)drawing size:(CGSize)size;

+ (UIImage *)drawEstimateCircleImageWithCircleScale:(CGFloat)circleScale imageSize:(CGSize)imageSize;

@end
