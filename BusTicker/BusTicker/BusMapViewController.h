//
//  BusMapViewController.h
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BusMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, weak) CLLocation* initialLocation;

@end
