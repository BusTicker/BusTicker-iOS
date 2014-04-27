//
//  LocationManager.m
//  BusTicker
//
//  Created by Brennan Stehling on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "LocationManager.h"

#define kLocationUpdateTimeout      5.0
#define kSimulatorLatitude          43.040038
#define kSimulatorLongitude         -87.904701

#pragma mark - Class Extension
#pragma mark -

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, copy) UpdatedLocationBlock updatedLocationBlock;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *bestLocation;
@property (nonatomic, strong) CLLocation *currentLocation;

@end

@implementation LocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        self.locationManager = locationManager;
        [self.locationManager setDesiredAccuracy: kCLLocationAccuracyHundredMeters];
        
        CLLocationCoordinate2D coordinate = kCLLocationCoordinate2DInvalid;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        self.currentLocation = location;
    }
    return self;
}

- (void)updateLocationWithCompletionBlock:(UpdatedLocationBlock)updatedLocationBlock {
    if ([CLLocationManager locationServicesEnabled]) {
        self.updatedLocationBlock = [updatedLocationBlock copy];
        [self updateCurrentLocation];
    }
}

#pragma mark - Location Monitoring
#pragma mark -

- (void)updateCurrentLocation {
    self.bestLocation = nil;
    NSCAssert(self.locationManager, @"Location Manager must be defined");
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(stopUpdatingLocationAfterTimeout) withObject:nil afterDelay:kLocationUpdateTimeout];
}

- (void)stopUpdatingLocation {
    [self finishWithBestLocation:self.bestLocation error:nil];
}

- (void)stopUpdatingLocationAfterTimeout {
    [self finishWithBestLocation:self.bestLocation error:nil];
}

- (void)finishWithBestLocation:(CLLocation *)location error:(NSError *)error {
    self.currentLocation = location;

    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;

    if (self.updatedLocationBlock) {
        if (error) {
            self.updatedLocationBlock(nil, error);
        }
        else {
            self.updatedLocationBlock(location, nil);
        }
        
        self.updatedLocationBlock = nil;
    }
}

#pragma mark - CLLocationManagerDelegate
#pragma mark -

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
#if TARGET_IPHONE_SIMULATOR
	CLLocation *location = [[CLLocation alloc] initWithLatitude:kSimulatorLatitude longitude:kSimulatorLongitude];
	[self finishWithBestLocation:location error:nil];
#endif
    
    if (locations.count) {
        CLLocation *latestLocation = (CLLocation *)[locations lastObject];
    
        if (self.bestLocation == nil) {
            // store the location as the "best effort"
            self.bestLocation = latestLocation;
        }

        // test that the horizontal accuracy does not indicate an invalid measurement
        if (latestLocation.horizontalAccuracy < 0) return;
        
        // set latest location to best effort
        if (latestLocation.horizontalAccuracy < self.bestLocation.horizontalAccuracy) {
            self.bestLocation = latestLocation;
        }
        
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This code depends on the timeout.
        //
        if (self.bestLocation.horizontalAccuracy <= manager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            //
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //
            [self finishWithBestLocation:self.bestLocation error:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if (error.code == kCLErrorDenied) {
        // log it
        NSLog(@"Location Services Denied");
	}
	else {
        // log it
        NSLog(@"Error: %@", error);
	}
    
    [self finishWithBestLocation:self.bestLocation error:error];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusRestricted) {
        [self stopUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusDenied) {
        [self stopUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusAuthorized) {
        //[self stopUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusNotDetermined) {
    }
    
}

@end
