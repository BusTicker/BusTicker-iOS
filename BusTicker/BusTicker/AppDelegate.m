//
//  AppDelegate.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "AppDelegate.h"

#import "LocationManager.h"
#import "ServiceManager.h"
#import "Route.h"

NSString * const AppDelegateDidUpdateLocationNotification = @"AppDelegateDidUpdateLocationNotification";
NSString * const AppDelegateRequestLocationUpdateNotification = @"AppDelegateRequestLocationUpdateNotification";
NSString * const AppDelegateDidLoadBusStopsNotification = @"AppDelegateDidLoadBusStopsNotification";

@implementation AppDelegate {
    NSArray *fetchedRoutes;
    NSMutableArray *fetchedBusStops;
    ServiceManager *sm;
}

#pragma mark - Properties
#pragma mark -

- (NSArray *)allStops {
    return fetchedBusStops;
}

#pragma mark - UIApplicationDelegate
#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    
    // set app UUID
    uuid_t myAppUUIDbytes;
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"7c88ad85-4732-47e9-ae66-9a303c8ab8d7"];
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    
    NSLog(@"Last connected watch: %@", [[PBPebbleCentral defaultCentral] lastConnectedWatch]);
    
    [self updateCurrentLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDelegateRequestLocationUpdateNotification:)
                                                 name:AppDelegateRequestLocationUpdateNotification
                                               object:nil];
    
    [self fetchRoutes];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self updateCurrentLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AppDelegateRequestLocationUpdateNotification
                                                  object:nil];
}

#pragma mark - PBPebbleCentralDelegate
#pragma mark -

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidConnect:(PBWatch*)watch isNew:(BOOL)isNew {
    NSLog(@"Pebble connected: %@", [watch name]);
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidDisconnect:(PBWatch*)watch {
    NSLog(@"Pebble disconnected: %@", [watch name]);
}

#pragma mark - Private
#pragma mark -

- (void)updateCurrentLocation {
    LocationManager *locationManager = [[LocationManager alloc] init];
    [locationManager updateLocationWithCompletionBlock:^(CLLocation *location, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            NSLog(@"Location: %0.7f, %0.7f", location.coordinate.latitude, location.coordinate.longitude);
            self.currentLocation = location;
            [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegateDidUpdateLocationNotification object:nil];
        }
    }];
}

- (void)fetchRoutes {
    sm = [[ServiceManager alloc] init];
    fetchedBusStops = [@[] mutableCopy];
    [sm fetchRoutesWithCompletionBlock:^(NSArray *routes, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            fetchedRoutes = routes;
            [self fetchBusStopsForRouteAtIndex:0];
        }
    }];
}

- (void)fetchBusStopsForRouteAtIndex:(NSInteger)index {
    if (index < fetchedRoutes.count) {
        Route *route = fetchedRoutes[index];
        
        [sm fetchStopsForRoute:route withCompletionBlock:^(NSArray *stops, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            }
            else {
                [fetchedBusStops addObjectsFromArray:stops];
                [self fetchBusStopsForRouteAtIndex:index+1];
            }
        }];
    }
    else {
        NSLog(@"Stops: %lu", (long)fetchedBusStops.count);
        [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegateDidLoadBusStopsNotification object:nil];
    }
}

#pragma mark - Notifications
#pragma mark -

- (void)appDelegateRequestLocationUpdateNotification:(NSNotification *)notification {
    [self updateCurrentLocation];
}

@end
