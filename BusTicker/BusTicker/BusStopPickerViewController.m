//
//  BusStopPickerViewController.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "BusStopPickerViewController.h"

#import <MapKit/MapKit.h>

#import "AppHelper.h"
#import "AppConfiguration.h"
#import "AppContext.h"

#import "BaseViewController.h"

@interface BusStopPickerViewController () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BusStopPickerViewController {
    BOOL _isMapPositioned;
}

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Stops";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_isMapPositioned) {
        [self repositionMap];
        _isMapPositioned = TRUE;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // TODO: load the bus stops for the visible region
    
    // Use MKMapRectContainsPoint to determine if a point should still be
    // available as an annotation view (add/remove)
    
    // See MKGeometry.h for more useful functions
    // valueWithMKCoordinate
}

#pragma mark - Private
#pragma mark -

- (void)repositionMap {
    CLLocationDistance radius = [AppConfiguration defaultRadius];
    CLLocationCoordinate2D coordinate = [[AppContext defaultInstance] currentCoordindate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, radius, radius);
    
    [self.mapView setRegion:region animated:FALSE];
}

- (CLLocationDistance)radius {
    MKCoordinateRegion region = self.mapView.region;
    CLLocationCoordinate2D center = region.center;
    
    CLLocation *boundaryLocation = [[CLLocation alloc] initWithLatitude:(center.latitude + region.span.latitudeDelta) longitude:center.longitude];
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    CLLocationDistance distance = [centerLocation distanceFromLocation:boundaryLocation];
    CLLocationDistance radius = distance / 2;
    
    return radius;
}

#pragma mark - MKMapViewDelegate
#pragma mark -

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // TODO: implement
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: implement
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
    static NSString *CellIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
}

@end
