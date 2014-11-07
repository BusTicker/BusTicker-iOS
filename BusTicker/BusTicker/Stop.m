//
//  Stop.m
//  BusTicker
//
//  Created by Brennan Stehling on 10/28/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "Stop.h"

#pragma mark - Class Extension
#pragma mark -

@interface Stop () <NSCopying, NSCoding>

@end

@implementation Stop

#pragma mark - NSObject Overrides
#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@] %@ - %@/%@ (%@)", NSStringFromClass([self class]), self.name, self.routeId, self.direction, self.stopId];
}


#pragma mark - Equality
#pragma mark -

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    else if ([other isKindOfClass:[Stop class]]) {
        return [self isEqualToStop:other];
    }
    
    return NO;
}

- (BOOL)isEqualToStop:(Stop *)other {
    return [self.stopId isEqualToString:other.stopId] && [self.routeId isEqualToString:other.routeId];
}

- (NSUInteger)hash {
    return self.stopId.hash;
}

#pragma mark - NSCopying
#pragma mark -

- (id)copyWithZone:(NSZone *)zone {
    Stop *copy = [[[self class] alloc] init];
    
    copy.direction = self.direction;
    copy.coordinate = self.coordinate;
    copy.name = self.name;
    copy.routeId = self.routeId;
    copy.stopId = self.stopId;
    
    return copy;
}

#pragma mark - NSCoding
#pragma mark -

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.direction forKey:@"direction"];
    
    [aCoder encodeObject:[NSNumber numberWithDouble:self.coordinate.latitude] forKey:@"latitude"];
    [aCoder encodeObject:[NSNumber numberWithDouble:self.coordinate.longitude] forKey:@"longitude"];
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.routeId forKey:@"routeId"];
    [aCoder encodeObject:self.stopId forKey:@"stopId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.direction = [aDecoder decodeObjectForKey:@"direction"];
    
    CLLocationDegrees latitude = [[aDecoder decodeObjectForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude = [[aDecoder decodeObjectForKey:@"longitude"] doubleValue];
    self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.routeId = [aDecoder decodeObjectForKey:@"routeId"];
    self.stopId = [aDecoder decodeObjectForKey:@"stopId"];
    
    return self;
}


@end
