//
//  BusStopPickerViewController.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "BusStopPickerViewController.h"

#import <MapKit/MapKit.h>

@interface BusStopPickerViewController () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation BusStopPickerViewController

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
