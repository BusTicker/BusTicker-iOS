//
//  Stop.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Stop : NSObject

@property (copy, nonatomic) NSString *direction;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *routeId;
@property (copy, nonatomic) NSString *stopId;

@end
