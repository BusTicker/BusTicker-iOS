//
//  AppConfiguration.m
//  BusTicker
//
//  Created by Brennan Stehling on 10/11/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "AppConfiguration.h"

@implementation AppConfiguration

+ (NSDictionary *)busTickerSettings {
    return [[NSBundle mainBundle] infoDictionary][@"BusTickerSettings"];
}

+ (CLLocationCoordinate2D)defaultLocationCoordinate {
    CLLocationDegrees defaultLatitude = [[self busTickerSettings][@"DefaultLatitude"] floatValue];
    CLLocationDegrees defaultLongitude = [[self busTickerSettings][@"DefaultLongitude"] floatValue];
    
    return CLLocationCoordinate2DMake(defaultLatitude, defaultLongitude);
}

+ (CLLocationDistance)defaultRadius {
    CLLocationDegrees defaultRadius = [[self busTickerSettings][@"DefaultRadius"] floatValue];
    
    return defaultRadius ? defaultRadius : 1000.0;
}

+ (NSString *)baseURL {
    return [self busTickerSettings][@"BaseURL"];
}

@end
