//
//  StopsRequest.m
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "StopsRequest.h"

@implementation StopsRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.page = 1;
        self.pageSize = 100;
    }
    return self;
}

@end
