//
//  AppContext.m
//  BusTicker
//
//  Created by Brennan Stehling on 10/11/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "AppContext.h"

#import "AppHelper.h"
#import "AppConfiguration.h"

#pragma mark - Class Extension
#pragma mark -

@interface AppContext () <CLLocationManagerDelegate>

@property (readwrite, strong, nonatomic) CLLocationManager *locationManager;
@property (readwrite, assign, nonatomic) CLLocationCoordinate2D currentCoordindate;

@end

@implementation AppContext

+ (instancetype)defaultInstance {
    static AppContext *_defaultInstance = nil;
    if (!_defaultInstance) {
        _defaultInstance = [[AppContext alloc] init];
        
        _defaultInstance.locationManager = [[CLLocationManager alloc] init];
        _defaultInstance.locationManager.delegate = _defaultInstance;
        
        _defaultInstance.currentCoordindate = kCLLocationCoordinate2DInvalid;
    }
    
    return _defaultInstance;
}

- (void)monitorSignificantLocationChanges {
    if ([self needsLocationServicesPermission]) {
        [self promptForLocationServicesPermission];
    }
    
    if (![self isLocationServicesAuthorized]) {
        self.currentCoordindate = [AppConfiguration defaultLocationCoordinate];
        DebugLog(@"coordinate: %f, %f", self.currentCoordindate.latitude, self.currentCoordindate.longitude);
    }
    else if (CLLocationCoordinate2DIsValid(self.locationManager.location.coordinate)) {
        self.currentCoordindate = self.locationManager.location.coordinate;
        DebugLog(@"coordinate: %f, %f", self.currentCoordindate.latitude, self.currentCoordindate.longitude);
    }
}

- (BOOL)needsLocationServicesPermission {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return [CLLocationManager locationServicesEnabled] && status == kCLAuthorizationStatusNotDetermined;
}

- (void)promptForLocationServicesPermission {
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    else {
        // prompt using legacy technique
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

- (BOOL)isLocationServicesAuthorized {
    BOOL isAuthorized = FALSE;
    
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        isAuthorized = status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse;
    }
    
    return isAuthorized;
}

#pragma mark - CLLocationManagerDelegate
#pragma mark -

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    DebugLog(@"Error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    DebugLog(@"locations: %@", locations);
    
    if (locations.count) {
        CLLocation *location = locations.lastObject;
        self.currentCoordindate = location.coordinate;
        DebugLog(@"coordinate: %f, %f", self.currentCoordindate.latitude, self.currentCoordindate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    BOOL isAuthorized = [self isLocationServicesAuthorized];
    
    if (isAuthorized && !self.locationManager) {
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

@end
