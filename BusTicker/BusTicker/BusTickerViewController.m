//
//  ViewController.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "BusTickerViewController.h"
#import "BusMapViewController.h"
#import "AppDelegate.h"

#define SYNC_KEY_ROUTE 0
#define SYNC_KEY_STOP 1
#define SYNC_KEY_FIRST_TIME 2
#define SYNC_KEY_SECOND_TIME 3

#pragma mark - Class Extension
#pragma mark -

@interface BusTickerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *firstTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondTimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *routeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *stopIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceToStopLabel;

@property (strong, nonatomic) IBOutlet UITextField *routeField;
@property (strong, nonatomic) IBOutlet UITextField *stopField;
@property (strong, nonatomic) IBOutlet UITextField *firstField;
@property (strong, nonatomic) IBOutlet UITextField *secondField;

@property (strong, nonatomic, readonly) CLLocation *currentLocation;

@end

#pragma mark -

@implementation BusTickerViewController

#pragma mark - Properties
#pragma mark -

- (CLLocation *)currentLocation {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.currentLocation;
}

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDelegateDidUpdateLocationNotification:)
                                                 name:AppDelegateDidUpdateLocationNotification
                                               object:nil];
    
    [self requestLocationUpdate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AppDelegateDidUpdateLocationNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private
#pragma mark -

- (void)requestLocationUpdate {
    [[NSNotificationCenter defaultCenter] postNotificationName:AppDelegateRequestLocationUpdateNotification object:nil];
}

#pragma mark - Pebble watch methods
#pragma mark -

- (void)syncTickerWithPebble {
    
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
#pragma mark -

- (IBAction)favoritesButtonPressed:(id)sender {
    [self syncTickerWithPebble];
}

- (IBAction)currentLocationPressed:(id)sender {
    [self requestLocationUpdate];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     if ([segue.identifier isEqualToString:@"BusMapSegue"]) {
//         BusMapViewController *dest = [segue destinationViewController];
//     }
}

#pragma mark - Notification
#pragma mark -

- (void)appDelegateDidUpdateLocationNotification:(NSNotification *)notification {
    // TODO: use the new current location
    
    if (self.currentLocation && CLLocationCoordinate2DIsValid(self.currentLocation.coordinate)) {
        NSLog(@"Current Location: %f, %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
    }
}

@end
