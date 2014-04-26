//
//  ViewController.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "BusTickerViewController.h"
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

@end

@implementation BusTickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Pebble watch methods

- (void) syncTickerWithPebble{
    
    PBWatch *watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    if(watch){
        // watch was found
        
        NSLog(@"Connected");
    #warning TODO - add real data
        // create a dictionary to be passed
        
//        NSString *first = [NSString stringWithFormat:@"%@ min", ];
//        NSString *second = [NSString stringWithFormat:@"%@ min", ];
        NSDictionary *busTickerInfo = @{
                                   @(SYNC_KEY_ROUTE) : @"GRE-S",
                                   @(SYNC_KEY_STOP) : @"Oakland-Locust",
                                   @(SYNC_KEY_FIRST_TIME) : @"10 min",
                                   @(SYNC_KEY_SECOND_TIME) : @"22 min"
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
    
}

- (IBAction)mapButtonPressed:(id)sender {
    [self syncTickerWithPebble];
}


@end
