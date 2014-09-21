//
//  PulsingView.h
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PulsingView : UIView

@property (nonatomic, strong) UIColor *innerColor; // default white
@property (nonatomic, strong) UIColor *outerColor; // default darkGray

@property (nonatomic, readwrite) CGFloat innerDiameter; // default bounds width
@property (nonatomic, readwrite) CGFloat outerDiameter; // default bounds width / 4

@property (nonatomic, readwrite) NSTimeInterval innerDuration; // default 2s
@property (nonatomic, readwrite) NSTimeInterval outerDuration; // default 3s

@property (nonatomic, readwrite) NSTimeInterval innerDelay; // default 1s
@property (nonatomic, readwrite) NSTimeInterval outerDelay; // default 2s

- (void)start;
- (void)stop;

@end
