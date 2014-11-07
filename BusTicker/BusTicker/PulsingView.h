//
//  PulsingView.h
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <UIKit/UIKit.h>

//#if !TARGET_INTERFACE_BUILDER
//#else
//#endif

IB_DESIGNABLE
@interface PulsingView : UIView

@property (nonatomic, strong) IBInspectable UIColor *innerColor; // default white
@property (nonatomic, strong) IBInspectable UIColor *outerColor; // default darkGray

@property (nonatomic, readwrite) IBInspectable CGFloat innerDiameter; // default bounds width
@property (nonatomic, readwrite) IBInspectable CGFloat outerDiameter; // default bounds width / 4

@property (nonatomic, readwrite) IBInspectable NSUInteger innerDuration; // default 2s
@property (nonatomic, readwrite) IBInspectable NSUInteger innerDelay; // default 1s

@property (nonatomic, readwrite) IBInspectable NSUInteger outerDuration; // default 3s
@property (nonatomic, readwrite) IBInspectable NSUInteger outerDelay; // default 2s

- (void)start;
- (void)stop;

@end
