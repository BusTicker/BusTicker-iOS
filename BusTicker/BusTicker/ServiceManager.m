//
//  ServiceManager.m
//  BusTicker
//
//  Created by Brennan Stehling on 4/27/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "ServiceManager.h"

#import <AFNetworking/AFNetworking.h>

//#define kBaseURL    @"http://bustickrdev.sstools.co:3000"
#define kBaseURL    @"http://localhost:3000"

@implementation ServiceManager

// http://bustickrdev.sstools.co:3000/routes
// [{"route":21,"direction":"EAST"},{"route":21,"direction":"WEST"}]
- (void)fetchRoutesWithCompletionBlock:(void (^)(NSArray *routes, NSError *error))completionBlock {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    [sessionManager GET:@"/routes" parameters:nil success:^(NSURLSessionDataTask *task, NSArray *routeData) {
        NSMutableArray *routes = [@[] mutableCopy];
        for (NSDictionary *dictionary in routeData) {
            Route *route = [[Route alloc] init];
            route.route = dictionary[@"route"];
            route.direction = dictionary[@"direction"];
            [routes addObject:route];
        }
        
        // TODO: parse response which is JSON likely as an NSDictionary
        
        if (completionBlock) {
            completionBlock(routes, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}

// http://bustickrdev.sstools.co:3000/stop/21/EAST/
- (void)fetchStopsForRoute:(Route *)route
     withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    NSString *path = [NSString stringWithFormat:@"/stop/%@/%@", route.route, route.direction];
    
    [sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSArray *stopData) {
        NSMutableArray *stops = [@[] mutableCopy];
        
        for (NSDictionary *dictionary in stopData) {
            BusStop *busStop = [[BusStop alloc] init];
            busStop.route = route;
            busStop.coordinate = CLLocationCoordinate2DMake([dictionary[@"lat"] floatValue], [dictionary[@"lon"] floatValue]);
            busStop.stopId = [dictionary[@"stopID"] integerValue];
            busStop.stopName = dictionary[@"stopName"];
            [stops addObject:busStop];
        }
        
        if (completionBlock) {
            completionBlock(stops, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}

// http://bustickrdev.sstools.co:3000/predictions/2220
//[{"age":0,"prediction":"2014-04-27T4:22-05:00","delayed":false,"route":"21","direction":"EAST"},{"age":0,"prediction":"2014-04-27T4:42-05:00","delayed":false,"route":"21","direction":"EAST"},{"age":0,"prediction":"2014-04-27T5:02-05:00","delayed":false,"route":"21","direction":"EAST"},{"age":0,"prediction":"2014-04-27T5:22-05:00","delayed":false,"route":"21","direction":"EAST"}]
- (void)fetchPredictionsForStop:(NSInteger)stopId withCompletionBlock:(void (^)(NSArray *predictions, NSError *error))completionBlock {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    NSDictionary *parameters = @{};
    
    NSString *path = [NSString stringWithFormat:@"/predictions/%li", (long)stopId];
    
    [sessionManager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response is a %@", NSStringFromClass([responseObject class]));
        NSLog(@"%@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            // TODO: parse response which is JSON likely as an NSDictionary
            if (completionBlock) {
                completionBlock(@[], nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}

@end
