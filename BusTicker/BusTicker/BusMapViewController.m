//
//  BusMapViewController.m
//  BusTicker
//
//  Created by Jake Widmer on 4/26/14.
//  Copyright (c) 2014 HardwareHackMKE. All rights reserved.
//

#import "BusMapViewController.h"

@interface BusMapViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation BusMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Mapview Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ( !self.initialLocation )
    {
        self.initialLocation = userLocation.location;
        
        MKCoordinateRegion region;
        region.center = mapView.userLocation.coordinate;
        region.span = MKCoordinateSpanMake(0.4, 0.4);
        
        region = [mapView regionThatFits:region];
        [mapView setRegion:region animated:YES];
    }
}

#pragma mark - Action Handlers
- (IBAction)selectButtonPressed:(id)sender {
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
