//
//  ViewController.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "BusTickerViewController.h"
#import "BusMapViewController.h"
#import "LocationManager.h"
#import "AppDelegate.h"

#define SYNC_KEY_ROUTE 0
#define SYNC_KEY_STOP 1
#define SYNC_KEY_FIRST_TIME 2
#define SYNC_KEY_SECOND_TIME 3

@interface BusTickerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *firstTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondTimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *routeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *stopIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceToStopLabel;

//
@property (strong, nonatomic) IBOutlet UITextField *routeField;
@property (strong, nonatomic) IBOutlet UITextField *stopField;
@property (strong, nonatomic) IBOutlet UITextField *firstField;
@property (strong, nonatomic) IBOutlet UITextField *secondField;

@end

@implementation BusTickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
    
    LocationManager *locationManager = [[LocationManager alloc] init];
    [locationManager updateLocationWithCompletionBlock:^(CLLocation *location, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            NSLog(@"Location: %0.7f, %0.7f", location.coordinate.latitude, location.coordinate.longitude);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Pebble watch methods

- (void) syncTickerWithPebble{
    
    PBWatch *watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    if(watch && [watch isConnected]){
        // watch was found
        NSLog(@"Connected");
    #warning TODO - add real data
        // create a dictionary to be passed
        
        NSString *first = [NSString stringWithFormat:@"%@ min", self.firstField.text];
        NSString *second = [NSString stringWithFormat:@"%@ min", self.secondField.text];
        NSDictionary *busTickerInfo = @{
                                   @(SYNC_KEY_ROUTE) : self.routeField.text,
                                   @(SYNC_KEY_STOP) : self.stopField.text,
                                   @(SYNC_KEY_FIRST_TIME) : first,
                                   @(SYNC_KEY_SECOND_TIME) : second
                                   };
        
        [watch appMessagesPushUpdate:busTickerInfo onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
            if (error) {
                NSLog(@"error sending update! %@", error);
            } else {
                NSLog(@"update: %@", update);
            }
        }];
    }else{
        // no watch was found
        NSLog(@"Disconnected");
        
    }
}

#pragma mark - Action handlers
- (IBAction)favoritesButtonPressed:(id)sender {
    [self syncTickerWithPebble];
}

- (IBAction)currentLocationPressed:(id)sender {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

 #pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"BusMapSegue"]) {
         BusMapViewController *dest = [segue destinationViewController];
         dest.initialLocation = self.currentLocation;
     }
}

@end
