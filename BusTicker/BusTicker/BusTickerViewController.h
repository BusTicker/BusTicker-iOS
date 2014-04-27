//
//  ViewController.h
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BusTickerViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation *currentLocation;

@end
