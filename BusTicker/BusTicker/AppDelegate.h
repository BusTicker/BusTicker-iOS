//
//  AppDelegate.h
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>
#import <CoreLocation/CoreLocation.h>

extern NSString * const AppDelegateDidUpdateLocationNotification;
extern NSString * const AppDelegateRequestLocationUpdateNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PBPebbleCentralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocation *currentLocation;

@end
