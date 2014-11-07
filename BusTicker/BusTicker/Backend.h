//
//  AppBackend.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StopsRequest.h"
#import "PredictionsRequest.h"
#import "Stop.h"

@interface Backend : NSObject

+ (void)fetchStops:(StopsRequest *)request withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock;

+ (void)fetchPredictions:(PredictionsRequest *)request withCompletionBlock:(void (^)(NSArray *predictions, NSError *error))completionBlock;

@end
