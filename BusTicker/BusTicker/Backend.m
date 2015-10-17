//
//  AppBackend.m
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "Backend.h"

#import "AppHelper.h"
#import "AppConfiguration.h"

// Stops
#define kParamLatitude @"lat"
#define kParamLongitude @"lon"
#define kParamRadius @"radius"
#define kParamPage @"page"
#define kParamPageSize @"pageSize"

// Predictions
#define kParamRoute @"route"
#define kParamStop @"stop"

#define kTimeoutInterval 20

@implementation Backend

static NSURLSession *session;

+ (void)fetchStops:(StopsRequest *)request withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock {
    if (!completionBlock) {
        return;
    }
    
    NSDictionary *params = @{
                             kParamLatitude : [NSNumber numberWithDouble:request.coordinate.latitude],
                             kParamLongitude : [NSNumber numberWithDouble:request.coordinate.longitude],
                             kParamRadius : [NSNumber numberWithDouble:request.radius / 1000], // converted from meters to kilometers
                             kParamPage : [NSNumber numberWithInteger:request.page],
                             kParamPageSize : [NSNumber numberWithInteger:request.pageSize]
                             };
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/stops", [AppConfiguration baseURL]]];
    [self fetchJsonRequestWithURL:url params:params withCompletionBlock:^(NSArray *items, NSError *error) {
        if (error) {
            DebugLog(@"Error: %@", error);
            completionBlock(nil, error);
        }
        else {
            NSMutableArray *stops = @[].mutableCopy;
            for (NSDictionary *dictionary in items) {
                Stop *stop = [[Stop alloc] init];
                
                CLLocationDegrees latitude = [dictionary[@"latitude"] doubleValue];
                CLLocationDegrees longitude = [dictionary[@"longitude"] doubleValue];

                stop.direction = dictionary[@"direction"];
                stop.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
                stop.name = dictionary[@"name"];
                stop.routeId = dictionary[@"routeId"];
                stop.stopId = dictionary[@"stopId"];
                [stops addObject:stop];
            }
            
            completionBlock(stops, nil);
        }
    }];
}

+ (void)fetchPredictions:(PredictionsRequest *)request withCompletionBlock:(void (^)(NSArray *predictions, NSError *error))completionBlock {
    if (!completionBlock) {
        return;
    }
    
    NSDictionary *params = @{
                             kParamRoute : request.route,
                             kParamStop : request.stop
                             };
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/predictions", [AppConfiguration baseURL]]];
    [self fetchJsonRequestWithURL:url params:params withCompletionBlock:^(NSArray *items, NSError *error) {
        if (error) {
            DebugLog(@"Error: %@", error);
            completionBlock(nil, error);
        }
        else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            
            NSMutableArray *predictions = @[].mutableCopy;
            for (NSDictionary *dictionary in items) {
                NSString *etaString = dictionary[@"eta"];
                NSDate *eta = [formatter dateFromString:etaString];
                [predictions addObject:eta];
            }

            completionBlock(predictions, nil);
        }
    }];
}

#pragma mark - Private
#pragma mark -

+ (void)fetchJsonRequestWithURL:(NSURL *)url params:(NSDictionary *)params withCompletionBlock:(void (^)(id response, NSError *error))completionBlock {
    if (!completionBlock) {
        return;
    }
    
    url = [self appendQueryParameters:params toURL:url];
    
    DebugLog(@"url: %@", url);
    
    if (session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completionBlock(nil, error);
        }
        else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error != nil) {
                completionBlock(nil, error);
            }
            else {
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dictionary = (NSDictionary *)json;
                    if ([dictionary[@"success"] boolValue]) {
                        completionBlock(dictionary[@"data"], nil);
                    }
                    else {
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : dictionary[@"message"]};
                        NSError *error = [NSError errorWithDomain:@"Backend" code:101 userInfo:userInfo];
                        completionBlock(nil, error);
                    }
                }
            }
        }
    }];
    [task resume];
}

+ (NSURL *)appendQueryParameters:(NSDictionary *)params toURL:(NSURL *)url {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = @[].mutableCopy;
    
    for (NSString *name in params) {
        NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:name value:[params[name] stringValue]];
        [queryItems addObject:item];
    }
    
    components.queryItems = queryItems;
    
    return components.URL;
}

@end
