//
//  AppHelper.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "AppHelper.h"

#import <UIKit/UIKit.h>

@implementation AppHelper

+ (UILabel *)labelWithTag:(NSUInteger)tag inView:(UIView *)view {
    id label = [view viewWithTag:tag];
    MAAssert([label isKindOfClass:[UILabel class]], @"UILabel is expected");
    
    return (UILabel *)label;
}

+ (UIButton *)buttonWithTag:(NSUInteger)tag inView:(UIView *)view {
    id button = [view viewWithTag:tag];
    MAAssert([button isKindOfClass:[UIButton class]], @"UIButton is expected");
    
    return (UIButton *)button;
}

+ (UIImageView *)imageViewWithTag:(NSUInteger)tag inView:(UIView *)view {
    id imageView = [view viewWithTag:tag];
    MAAssert([imageView isKindOfClass:[UIImageView class]], @"UIImageView is expected");
    
    return (UIImageView *)imageView;
}

@end
