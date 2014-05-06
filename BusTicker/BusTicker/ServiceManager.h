//
//  ServiceManager.h
//  BusTicker
//
//  Created by Brennan Stehling on 4/27/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Route.h"
#import "BusStop.h"

@interface ServiceManager : NSObject

- (void)fetchRoutesWithCompletionBlock:(void (^)(NSArray *routes, NSError *error))completionBlock;

- (void)fetchStopsForRoute:(Route *)route
       withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock;

- (void)fetchPredictionsForStop:(NSInteger)stopId withCompletionBlock:(void (^)(NSArray *predictions, NSError *error))completionBlock;

@end
