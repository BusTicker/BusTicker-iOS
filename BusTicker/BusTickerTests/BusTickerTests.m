//
//  BusTickerTests.m
//  BusTickerTests
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Stop.h"

@interface BusTickerTests : XCTestCase

@end

@implementation BusTickerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStopForNSCoding {
    // This is an example of a performance test case.
    
    Stop *stop = [[Stop alloc] init];
    stop.direction = @"WEST";
    stop.coordinate = CLLocationCoordinate2DMake(43.049462579534, -87.898241822089);
    stop.name = @"HUMBOLDT + LYON";
    stop.routeId = @"10";
    stop.stopId = @"464";
    
    Stop *copy = stop.copy;
    
    XCTAssertTrue([stop.direction isEqualToString:copy.direction]);
    XCTAssertTrue(stop.coordinate.latitude == copy.coordinate.latitude);
    XCTAssertTrue(stop.coordinate.longitude == copy.coordinate.longitude);
    XCTAssertTrue([stop.name isEqualToString:copy.name]);
    XCTAssertTrue([stop.routeId isEqualToString:copy.routeId]);
    XCTAssertTrue([stop.stopId isEqualToString:copy.stopId]);
}

- (void)testStopForEquals {
    // This is an example of a performance test case.
    
    Stop *stop = [[Stop alloc] init];
    stop.direction = @"WEST";
    stop.coordinate = CLLocationCoordinate2DMake(43.049462579534, -87.898241822089);
    stop.name = @"HUMBOLDT + LYON";
    stop.routeId = @"10";
    stop.stopId = @"464";
    
    Stop *copy = stop.copy;
    
    XCTAssertTrue([stop isEqual:copy]);
}

@end
