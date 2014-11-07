//
//  StopsRequest.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface StopsRequest : NSObject

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (assign, nonatomic) CLLocationDistance radius;
@property (assign, nonatomic) NSUInteger page; // default 1
@property (assign, nonatomic) NSUInteger pageSize; // default 100 (the data is small)

@end
