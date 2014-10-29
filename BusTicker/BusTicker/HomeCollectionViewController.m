//
//  HomeCollectionViewController.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "HomeCollectionViewController.h"

#import <CoreLocation/CoreLocation.h>

#import "AppHelper.h"
#import "AppConfiguration.h"
#import "AppContext.h"

#import "Backend.h"

#import "StyleKit+Additions.h"
#import "PulsingView.h"

#pragma mark -

#define kTagBusStopLabel 10
#define kTagRouteLabel 11

#define kTagPulsingView 20
#define kTagEstimateLabel 21
#define kTagMinutesLabel 22

#define kTagQuickSelectButton 30
#define kTagQuickSelectLabel 31

#define kTagFavoriteButton 40
#define kTagFavoriteLabel 41

#define kTagForecastImageView 50
#define kTagTemperatureLabel 51

#define kTagDirectionsButton 60
#define kTagDistanceLabel 61

#pragma mark -

@interface HomeCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

#pragma mark -

@implementation HomeCollectionViewController

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    StopsRequest *stopsRequest = [[StopsRequest alloc] init];
//    stopsRequest.coordinate = CLLocationCoordinate2DMake(43.053278377347, -87.903306511242);
//    stopsRequest.radius = 0.75;
//    stopsRequest.page = 1;
//    stopsRequest.pageSize = 3;
//    
//    [Backend fetchStops:stopsRequest withCompletionBlock:^(NSArray *stops, NSError *error) {
//        DebugLog(@"stops: %@", stops);
//    }];
    
//    PredictionsRequest *predictionsRequest = [[PredictionsRequest alloc] init];
//    predictionsRequest.route = @"GRE";
//    predictionsRequest.stop = @"1417";
//    
//    [Backend fetchPredictions:predictionsRequest withCompletionBlock:^(NSArray *predictions, NSError *error) {
//        DebugLog(@"predictions: %@", predictions);
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIButton *busStopsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [busStopsButton addTarget:self action:@selector(busStopsPickerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    busStopsButton.frame = CGRectMake(0, 0, 30, 30);
    [busStopsButton setImage:[StyleKit drawImage:DrawingBusStop size:busStopsButton.frame.size] forState:UIControlStateNormal];
    UIBarButtonItem *busStopsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:busStopsButton];
    
    [self.navigationItem setRightBarButtonItem:busStopsBarButtonItem animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //self.collectionView.frame = self.view.bounds;
    [[AppContext defaultInstance] monitorSignificantLocationChanges];
}

#pragma mark - User Action
#pragma mark -

- (void)busStopsPickerButtonTapped:(UIButton *)button {
    // TODO: implement
    DebugLog(@"%@", NSStringFromSelector(_cmd));
    [self performSegueWithIdentifier:@"ShowBusStopPicker" sender:self];
}

- (void)quickSelectButtonTapped:(UIButton *)button {
    // TODO: implement
    DebugLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)starButtonTapped:(UIButton *)button {
    // TODO: implement
    DebugLog(@"%@", NSStringFromSelector(_cmd));
    button.selected = !button.selected;
}

- (void)directionsButtonTapped:(UIButton *)button {
    DebugLog(@"%@", NSStringFromSelector(_cmd));
    // TODO: implement
}

#pragma mark - Private
#pragma mark -

// nothing

#pragma mark - Animations
#pragma mark -

- (void)animatePulsingView:(PulsingView *)pulsingView atIndexPath:(NSIndexPath *)indexPath {
    [pulsingView stop];
    
    pulsingView.innerColor = indexPath.item % 2 == 0 ? [[UIColor whiteColor] colorWithAlphaComponent:0.25] : [[UIColor darkGrayColor] colorWithAlphaComponent:0.25];
    pulsingView.outerColor = [UIColor colorWithRed:0.0392 green:0.3216 blue:0.5922 alpha:0.5];
    
    pulsingView.innerDiameter = CGRectGetWidth(pulsingView.frame) * 0.75;
    pulsingView.outerDiameter = CGRectGetWidth(pulsingView.frame);
    
    pulsingView.innerDuration = 6;
    pulsingView.innerDelay = 1;
    
    pulsingView.outerDuration = 5;
    pulsingView.outerDelay = 2;
    
    [pulsingView start];
}

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // TODO: implement
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BusStopCell" forIndexPath:indexPath];
    
    UILabel *busStopLabel = [AppHelper labelWithTag:kTagBusStopLabel inView:cell];
    UILabel *routeLabel = [AppHelper labelWithTag:kTagRouteLabel inView:cell];
    UILabel *mainNumberLabel = [AppHelper labelWithTag:kTagEstimateLabel inView:cell];
    UILabel *minutesLabel = [AppHelper labelWithTag:kTagMinutesLabel inView:cell];
    UILabel *temperatureLabel = [AppHelper labelWithTag:kTagTemperatureLabel inView:cell];

    busStopLabel.text = @"Bus Stop";
    routeLabel.text = @"Route";
    mainNumberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(indexPath.item + 1) * 3];
    minutesLabel.text = @"minutes";
    
    temperatureLabel.text = @"67";
    
    UIImageView *forecastImageView = [AppHelper imageViewWithTag:kTagForecastImageView inView:cell];
    
    UIButton *quickSelectButton = [AppHelper buttonWithTag:kTagQuickSelectButton inView:cell];
    UIButton *starButton = [AppHelper buttonWithTag:kTagFavoriteButton inView:cell];
    UIButton *directionsButton = [AppHelper buttonWithTag:kTagDirectionsButton inView:cell];
    
    UIImage *forecastImage = [StyleKit drawImage:DrawingForecast size:forecastImageView.frame.size];
    forecastImageView.image = forecastImage;
    
    PulsingView *pulsingView = (PulsingView *)[cell viewWithTag:kTagPulsingView];
    [self animatePulsingView:pulsingView atIndexPath:indexPath];
    
    UIImage *pickerImage = [StyleKit drawImage:DrawingPicker size:CGSizeMake(50, 50)];
    [quickSelectButton setImage:pickerImage forState:UIControlStateNormal];
    [quickSelectButton setTitle:nil forState:UIControlStateNormal];
    
    [quickSelectButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [quickSelectButton addTarget:self action:@selector(quickSelectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    UIImage *starOffImage = [StyleKit drawImage:DrawingStarOff size:CGSizeMake(50, 50)];
    UIImage *starOnImage = [StyleKit drawImage:DrawingStarOn size:CGSizeMake(50, 50)];
    [starButton setImage:starOffImage forState:UIControlStateNormal];
    [starButton setImage:starOnImage forState:UIControlStateSelected];
    [starButton setTitle:nil forState:UIControlStateNormal];
    
    [starButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [starButton addTarget:self action:@selector(starButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *directionsImage = [StyleKit drawImage:DrawingDirections size:CGSizeMake(50, 50)];
    [directionsButton setImage:directionsImage forState:UIControlStateNormal];
    [directionsButton setTitle:nil forState:UIControlStateNormal];
    
    [directionsButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [directionsButton addTarget:self action:@selector(directionsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
    NSLog(@"Selected item!");
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
