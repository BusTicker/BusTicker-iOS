//
//  BusStop.h
//  BusTicker
//
//  Created by Brennan Stehling on 4/27/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Route.h"

@interface BusStop : NSObject

@property (strong, nonatomic) Route *route;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (assign, nonatomic) NSInteger stopId;
@property (copy, nonatomic) NSString *stopName;

@end
