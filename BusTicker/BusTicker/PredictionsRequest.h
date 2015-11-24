//
//  PredictionsRequest.h
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredictionsRequest : NSObject

@property (copy, nonatomic) NSString *route;
@property (copy, nonatomic) NSString *stop;

@end
