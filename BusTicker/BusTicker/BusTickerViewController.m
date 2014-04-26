//
//  ViewController.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "BusTickerViewController.h"

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

#pragma mark - Action handlers
- (IBAction)favoritesButtonPressed:(id)sender {
    
}

- (IBAction)mapButtonPressed:(id)sender {
    
}


@end
