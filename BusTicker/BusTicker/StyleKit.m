//
//  StyleKit.m
//  Bus Ticker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 Bus Ticker. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "StyleKit.h"


@implementation StyleKit

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawDirectionsWithScale: (CGFloat)scale;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* myWhite = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Variable Declarations
    CGFloat scaleX = scale / 100.0;
    CGFloat scaleY = scale / 100.0;

    //// Group
    {
        CGContextSaveGState(context);
        CGContextScaleCTM(context, scaleX, scaleY);



        //// MapPin Drawing
        UIBezierPath* mapPinPath = UIBezierPath.bezierPath;
        [mapPinPath moveToPoint: CGPointMake(208.94, 325.09)];
        [mapPinPath addLineToPoint: CGPointMake(220.81, 354.78)];
        [mapPinPath addCurveToPoint: CGPointMake(186.66, 365.22) controlPoint1: CGPointMake(209.31, 359.38) controlPoint2: CGPointMake(197.84, 362.88)];
        [mapPinPath addLineToPoint: CGPointMake(180.13, 333.91)];
        [mapPinPath addCurveToPoint: CGPointMake(208.94, 325.09) controlPoint1: CGPointMake(189.5, 331.94) controlPoint2: CGPointMake(199.19, 328.97)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(113.72, 363.44)];
        [mapPinPath addCurveToPoint: CGPointMake(150.41, 368.81) controlPoint1: CGPointMake(125.44, 366.81) controlPoint2: CGPointMake(137.78, 368.63)];
        [mapPinPath addLineToPoint: CGPointMake(150.91, 336.81)];
        [mapPinPath addCurveToPoint: CGPointMake(122.56, 332.69) controlPoint1: CGPointMake(141.09, 336.66) controlPoint2: CGPointMake(131.56, 335.28)];
        [mapPinPath addLineToPoint: CGPointMake(113.72, 363.44)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(365.69, 307.59)];
        [mapPinPath addCurveToPoint: CGPointMake(392.44, 316.97) controlPoint1: CGPointMake(374.91, 309.41) controlPoint2: CGPointMake(383.91, 312.56)];
        [mapPinPath addLineToPoint: CGPointMake(407.13, 288.53)];
        [mapPinPath addCurveToPoint: CGPointMake(371.88, 276.22) controlPoint1: CGPointMake(395.88, 282.75) controlPoint2: CGPointMake(384.03, 278.59)];
        [mapPinPath addLineToPoint: CGPointMake(365.69, 307.59)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(298.94, 281.34)];
        [mapPinPath addLineToPoint: CGPointMake(308.5, 311.84)];
        [mapPinPath addCurveToPoint: CGPointMake(337.25, 306.09) controlPoint1: CGPointMake(318.28, 308.78) controlPoint2: CGPointMake(327.94, 306.84)];
        [mapPinPath addLineToPoint: CGPointMake(334.69, 274.22)];
        [mapPinPath addCurveToPoint: CGPointMake(298.94, 281.34) controlPoint1: CGPointMake(323, 275.16) controlPoint2: CGPointMake(310.97, 277.56)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(247.56, 305.41)];
        [mapPinPath addCurveToPoint: CGPointMake(236.97, 311.66) controlPoint1: CGPointMake(243.97, 307.66) controlPoint2: CGPointMake(240.44, 309.72)];
        [mapPinPath addLineToPoint: CGPointMake(252.53, 339.59)];
        [mapPinPath addCurveToPoint: CGPointMake(264.44, 332.59) controlPoint1: CGPointMake(256.44, 337.41) controlPoint2: CGPointMake(260.44, 335.09)];
        [mapPinPath addCurveToPoint: CGPointMake(280.59, 323.47) controlPoint1: CGPointMake(269.94, 329.19) controlPoint2: CGPointMake(275.31, 326.16)];
        [mapPinPath addLineToPoint: CGPointMake(266.06, 294.97)];
        [mapPinPath addCurveToPoint: CGPointMake(247.56, 305.41) controlPoint1: CGPointMake(260.06, 298.03) controlPoint2: CGPointMake(253.88, 301.5)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(336, 106)];
        [mapPinPath addCurveToPoint: CGPointMake(327.31, 142.31) controlPoint1: CGPointMake(336, 119.06) controlPoint2: CGPointMake(332.88, 131.44)];
        [mapPinPath addLineToPoint: CGPointMake(256, 282)];
        [mapPinPath addCurveToPoint: CGPointMake(183.84, 140.56) controlPoint1: CGPointMake(256, 282) controlPoint2: CGPointMake(184.12, 141.16)];
        [mapPinPath addCurveToPoint: CGPointMake(176, 106) controlPoint1: CGPointMake(178.81, 130.12) controlPoint2: CGPointMake(176, 118.38)];
        [mapPinPath addCurveToPoint: CGPointMake(256, 26) controlPoint1: CGPointMake(176, 61.81) controlPoint2: CGPointMake(211.81, 26)];
        [mapPinPath addCurveToPoint: CGPointMake(336, 106) controlPoint1: CGPointMake(300.19, 26) controlPoint2: CGPointMake(336, 61.81)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(304, 106)];
        [mapPinPath addCurveToPoint: CGPointMake(256, 58) controlPoint1: CGPointMake(304, 79.5) controlPoint2: CGPointMake(282.5, 58)];
        [mapPinPath addCurveToPoint: CGPointMake(208, 106) controlPoint1: CGPointMake(229.5, 58) controlPoint2: CGPointMake(208, 79.5)];
        [mapPinPath addCurveToPoint: CGPointMake(256, 154) controlPoint1: CGPointMake(208, 132.5) controlPoint2: CGPointMake(229.5, 154)];
        [mapPinPath addCurveToPoint: CGPointMake(304, 106) controlPoint1: CGPointMake(282.5, 154) controlPoint2: CGPointMake(304, 132.5)];
        [mapPinPath closePath];
        [mapPinPath moveToPoint: CGPointMake(416, 186)];
        [mapPinPath addLineToPoint: CGPointMake(340.94, 186)];
        [mapPinPath addLineToPoint: CGPointMake(324.59, 218)];
        [mapPinPath addLineToPoint: CGPointMake(392.94, 218)];
        [mapPinPath addLineToPoint: CGPointMake(427.47, 321.62)];
        [mapPinPath addLineToPoint: CGPointMake(416.44, 333.81)];
        [mapPinPath addCurveToPoint: CGPointMake(434.31, 354.25) controlPoint1: CGPointMake(428.19, 344.44) controlPoint2: CGPointMake(434.28, 354.22)];
        [mapPinPath addLineToPoint: CGPointMake(437.69, 352.22)];
        [mapPinPath addLineToPoint: CGPointMake(467.59, 442)];
        [mapPinPath addLineToPoint: CGPointMake(44.38, 442)];
        [mapPinPath addLineToPoint: CGPointMake(76.44, 345.91)];
        [mapPinPath addCurveToPoint: CGPointMake(79.69, 348.22) controlPoint1: CGPointMake(77.56, 346.69) controlPoint2: CGPointMake(78.44, 347.44)];
        [mapPinPath addLineToPoint: CGPointMake(96.69, 321.16)];
        [mapPinPath addCurveToPoint: CGPointMake(87, 314.16) controlPoint1: CGPointMake(92.88, 318.75) controlPoint2: CGPointMake(89.75, 316.38)];
        [mapPinPath addLineToPoint: CGPointMake(119.06, 218)];
        [mapPinPath addLineToPoint: CGPointMake(187.44, 218)];
        [mapPinPath addCurveToPoint: CGPointMake(171.09, 186) controlPoint1: CGPointMake(180.66, 204.75) controlPoint2: CGPointMake(175.31, 194.28)];
        [mapPinPath addLineToPoint: CGPointMake(96, 186)];
        [mapPinPath addLineToPoint: CGPointMake(0, 474)];
        [mapPinPath addLineToPoint: CGPointMake(512, 474)];
        [mapPinPath addLineToPoint: CGPointMake(416, 186)];
        [mapPinPath closePath];
        mapPinPath.miterLimit = 4;

        [myWhite setFill];
        [mapPinPath fill];



        CGContextRestoreGState(context);
    }
}

+ (void)drawStarWithStarred: (BOOL)starred scale: (CGFloat)scale;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* myWhite = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* myYellow = [UIColor colorWithRed: 1 green: 0.872 blue: 0 alpha: 1];

    //// Variable Declarations
    UIColor* starredColor = starred ? myYellow : myWhite;
    CGFloat scaleX = scale / 100.0;
    CGFloat scaleY = scale / 100.0;

    //// Group
    {
        CGContextSaveGState(context);
        CGContextScaleCTM(context, scaleX, scaleY);



        //// Star 2 Drawing
        UIBezierPath* star2Path = UIBezierPath.bezierPath;
        [star2Path moveToPoint: CGPointMake(256, 30.5)];
        [star2Path addLineToPoint: CGPointMake(338.7, 151.17)];
        [star2Path addLineToPoint: CGPointMake(479.02, 192.54)];
        [star2Path addLineToPoint: CGPointMake(389.81, 308.48)];
        [star2Path addLineToPoint: CGPointMake(393.84, 454.71)];
        [star2Path addLineToPoint: CGPointMake(256, 405.7)];
        [star2Path addLineToPoint: CGPointMake(118.16, 454.71)];
        [star2Path addLineToPoint: CGPointMake(122.19, 308.48)];
        [star2Path addLineToPoint: CGPointMake(32.98, 192.54)];
        [star2Path addLineToPoint: CGPointMake(173.3, 151.17)];
        [star2Path closePath];
        [starredColor setFill];
        [star2Path fill];



        CGContextRestoreGState(context);
    }
}

+ (void)drawPickerWithScale: (CGFloat)scale;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* myWhite = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Variable Declarations
    CGFloat scaleX = scale / 100.0;
    CGFloat scaleY = scale / 100.0;

    //// Group
    {
        CGContextSaveGState(context);
        CGContextScaleCTM(context, scaleX, scaleY);



        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(72, 229)];
        [bezierPath addLineToPoint: CGPointMake(236, 229)];
        [bezierPath addLineToPoint: CGPointMake(236, 65)];
        [bezierPath addLineToPoint: CGPointMake(72, 65)];
        [bezierPath addLineToPoint: CGPointMake(72, 229)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(275, 229)];
        [bezierPath addLineToPoint: CGPointMake(439, 229)];
        [bezierPath addLineToPoint: CGPointMake(439, 65)];
        [bezierPath addLineToPoint: CGPointMake(275, 65)];
        [bezierPath addLineToPoint: CGPointMake(275, 229)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(275, 432)];
        [bezierPath addLineToPoint: CGPointMake(439, 432)];
        [bezierPath addLineToPoint: CGPointMake(439, 268)];
        [bezierPath addLineToPoint: CGPointMake(275, 268)];
        [bezierPath addLineToPoint: CGPointMake(275, 432)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(72, 432)];
        [bezierPath addLineToPoint: CGPointMake(236, 432)];
        [bezierPath addLineToPoint: CGPointMake(236, 268)];
        [bezierPath addLineToPoint: CGPointMake(72, 268)];
        [bezierPath addLineToPoint: CGPointMake(72, 432)];
        [bezierPath closePath];
        [myWhite setFill];
        [bezierPath fill];



        CGContextRestoreGState(context);
    }
}

+ (void)drawEstimateCircleWithCircleScale: (CGFloat)circleScale scale: (CGFloat)scale;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* myWhite = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* myTransparentWhite = [myWhite colorWithAlphaComponent: 0.5];
    UIColor* myGray = [UIColor colorWithRed: 0.784 green: 0.784 blue: 0.784 alpha: 1];
    UIColor* myTransparentGray = [myGray colorWithAlphaComponent: 0.5];

    //// Variable Declarations
    CGFloat circleScaleCalculated = circleScale / 100.0 * 470;
    CGFloat circleOffsetCalculated = (512 - circleScaleCalculated) / 2.0;
    CGFloat scaleX = scale / 100.0;
    CGFloat scaleY = scale / 100.0;

    //// Group
    {
        CGContextSaveGState(context);
        CGContextScaleCTM(context, scaleX, scaleY);



        //// Circle Drawing
        UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(circleOffsetCalculated, circleOffsetCalculated, circleScaleCalculated, circleScaleCalculated)];
        [myTransparentGray setFill];
        [circlePath fill];


        //// Inner Circle Drawing
        UIBezierPath* innerCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(136, 136, 240, 240)];
        [myTransparentWhite setFill];
        [innerCirclePath fill];



        CGContextRestoreGState(context);
    }
}

@end