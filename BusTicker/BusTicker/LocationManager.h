//
//  LocationManager.h
//  BusTicker
//
//  Created by Brennan Stehling on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^UpdatedLocationBlock)(CLLocation *location, NSError *error);

@interface LocationManager : NSObject

- (void)updateLocationWithCompletionBlock:(UpdatedLocationBlock)updatedLocationBlock;

@end
