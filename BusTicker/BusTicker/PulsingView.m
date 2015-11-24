//
//  PulsingView.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "PulsingView.h"

#import <QuartzCore/QuartzCore.h>

#pragma mark - Class Extension
#pragma mark -

@interface PulsingView ()

@property (nonatomic, strong) CALayer *innerLayer;
@property (nonatomic, strong) CALayer *outerLayer;

@end

@implementation PulsingView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    _innerColor = [UIColor whiteColor];
    _outerColor = [UIColor darkGrayColor];
    
    _innerDiameter = CGRectGetWidth(self.bounds) / 4;
    _outerDiameter = CGRectGetWidth(self.bounds);
    
    _innerDuration = 2;
    _outerDuration = 3;
    
    _innerDelay = 1;
    _outerDelay = 2;
}

- (void)prepareForInterfaceBuilder {
    [self start];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self rebuildLayers];
    }
}

- (void)start {
    [self stop];
    
    [self.layer addSublayer:self.outerLayer];
    [self.layer addSublayer:self.innerLayer];
}

- (void)stop {
    [_innerLayer removeFromSuperlayer];
    _innerLayer = nil;
    
    [_outerLayer removeFromSuperlayer];
    _outerLayer = nil;
}

- (void)rebuildLayers {
    [self start];
}

- (CALayer*)innerLayer {
    if(!_innerLayer) {
        _innerLayer = [self animatedLayerWithDiameter:self.innerDiameter color:self.innerColor duration:self.innerDuration delay:self.innerDelay];
    }
    
    return _innerLayer;
}

- (CALayer*)outerLayer {
    if(!_outerLayer) {
        _outerLayer = [self animatedLayerWithDiameter:self.outerDiameter color:self.outerColor duration:self.outerDuration delay:self.outerDelay];
    }
    
    return _outerLayer;
}

- (CALayer *)animatedLayerWithDiameter:(CGFloat)diameter color:(UIColor *)color duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    CALayer *animatedLayer = [CALayer layer];
    animatedLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    animatedLayer.allowsGroupOpacity = YES;
    animatedLayer.backgroundColor = color.CGColor;
    animatedLayer.cornerRadius = diameter/2;
    animatedLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        if (delay != INFINITY) {
            CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            
            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = duration;
            animationGroup.repeatCount = INFINITY;
            animationGroup.removedOnCompletion = NO;
            animationGroup.autoreverses = YES;
            animationGroup.beginTime = 1;
            animationGroup.timingFunction = defaultCurve;
            animationGroup.speed = 1;
            animationGroup.fillMode = kCAFillModeBoth;
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
            scaleAnimation.fromValue = @0.5;
            scaleAnimation.toValue = @1;
            scaleAnimation.duration = duration;
            
            CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            opacityAnimation.fromValue = @0.75;
            opacityAnimation.toValue = @0.9;
            opacityAnimation.duration = duration;
            
            animationGroup.animations = @[scaleAnimation, opacityAnimation];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [animatedLayer addAnimation:animationGroup forKey:@"pulse"];
            });
        }
    });
    
    return animatedLayer;
}

@end
