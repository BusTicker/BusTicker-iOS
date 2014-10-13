//
//  AppContext.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/11/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AppContext : NSObject

@property (readonly, nonatomic) CLLocationManager *locationManager;
@property (readonly, nonatomic) CLLocationCoordinate2D currentCoordindate;

+ (instancetype)defaultInstance;

- (void)monitorSignificantLocationChanges;

- (BOOL)needsLocationServicesPermission;

- (void)promptForLocationServicesPermission;

- (BOOL)isLocationServicesAuthorized;

@end
