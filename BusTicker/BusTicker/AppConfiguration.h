//
//  AppConfiguration.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/11/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AppConfiguration : NSObject

+ (CLLocationCoordinate2D)defaultLocationCoordinate;
+ (CLLocationDistance)defaultRadius;

@end
