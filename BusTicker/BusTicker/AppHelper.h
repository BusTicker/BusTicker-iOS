//
//  AppHelper.h
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

// Make sure NDEBUG is defined on Release
#ifndef NDEBUG

#define DebugLog(message, ...) NSLog(@"%s: " message, __PRETTY_FUNCTION__, ##__VA_ARGS__)

#else

#define DebugLog(message, ...)

#endif

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define isiOS7OrLater floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1

#define LOG_FRAME(label, frame) DebugLog(@"%@: %f, %f, %f, %f", label, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
#define LOG_SIZE(label, size) DebugLog(@"%@, %f, %f", label, size.width, size.height)
#define LOG_POINT(label, point) DebugLog(@"%@: %f, %f", label, point.x, point.y)
#define LOG_OFFSET(label, offset) DebugLog(@"%@: %f, %f", label, offset.x, offset.y)
#define LOG_INSET(label, inset) DebugLog(@"%@: %f, %f, %f, %f", label, inset.top, inset.left, inset.bottom, inset.right)
#define LOG_INDEXPATH(label, indexPath) DebugLog(@"%@: %li, %li", label, indexPath.section, indexPath.row)
#define LOG_INDEXPATH2(label, indexPath) DebugLog(@"%@: %li, %li", label, indexPath.section, indexPath.item)

#ifndef NS_BLOCK_ASSERTIONS

// Credit: http://sstools.co/maassert
#define MAAssert(expression, ...) \
do { \
if(!(expression)) { \
NSLog(@"Assertion failure: %s in %s on line %s:%d. %@", #expression, __func__, __FILE__, __LINE__, [NSString stringWithFormat: @"" __VA_ARGS__]); \
abort(); \
} \
} while(0)

#else

#define MAAssert(expression, ...)

#endif

@interface AppHelper : NSObject

+ (UILabel *)labelWithTag:(NSUInteger)tag inView:(UIView *)view;

+ (UIButton *)buttonWithTag:(NSUInteger)tag inView:(UIView *)view;

+ (UIImageView *)imageViewWithTag:(NSUInteger)tag inView:(UIView *)view;

@end
