//
//  HomeCollectionViewController.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "HomeCollectionViewController.h"

#import "AppHelper.h"
#import "StyleKit+Additions.h"

#import "PulsingView.h"

#pragma mark -

#define kTagBusStopLabel 1
#define kTagRouteLabel 2
#define kTagMainImageView 3
#define kTagMainNumberLabel 4
#define kTagMinutesLabel 5
#define kTagWeatherImageView 6
#define kTagTemperatureLabel 7
#define kTagPickerButton 8
#define kTagStarButton 9
#define kTagDirectionsbutton 10
#define kTagDistanceLabel 11

#define kTagPulsingView 12

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
    
    LOG_INSET(@"collection view inset", self.collectionView.contentInset);
    
    [self.collectionView setContentInset:UIEdgeInsetsZero];
//    [self.collectionView sets]
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    LOG_FRAME(@"home view", self.view.frame);
    LOG_FRAME(@"collection view", self.collectionView.frame);
    
    UIButton *busStopsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [busStopsButton addTarget:self action:@selector(busStopsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    busStopsButton.frame = CGRectMake(0, 0, 30, 30);
    [busStopsButton setImage:[StyleKit drawImage:DrawingBusStop size:busStopsButton.frame.size] forState:UIControlStateNormal];
    UIBarButtonItem *busStopsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:busStopsButton];
    
    [self.navigationItem setRightBarButtonItem:busStopsBarButtonItem animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.collectionView reloadData];
    
    self.collectionView.frame = self.view.bounds;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - User Action
#pragma mark -

- (void)busStopsButtonTapped:(UIButton *)button {
    // TODO: implement
    DebugLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)pickerButtonTapped:(UIButton *)button {
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

#pragma mark - Animations
#pragma mark -

- (void)animatePulsingView:(PulsingView *)pulsingView {
    [pulsingView stop];
    
    pulsingView.innerColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.25];
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
    
    //cell.backgroundColor = [UIColor redColor];
    
    UILabel *busStopLabel = [AppHelper labelWithTag:kTagBusStopLabel inView:cell];
    UILabel *routeLabel = [AppHelper labelWithTag:kTagRouteLabel inView:cell];
    UILabel *mainNumberLabel = [AppHelper labelWithTag:kTagMainNumberLabel inView:cell];
    UILabel *minutesLabel = [AppHelper labelWithTag:kTagMinutesLabel inView:cell];
    
    UIImageView *mainImageView = [AppHelper imageViewWithTag:kTagMainImageView inView:cell];
    
    UIButton *pickerButton = [AppHelper buttonWithTag:kTagPickerButton inView:cell];
    UIButton *starButton = [AppHelper buttonWithTag:kTagStarButton inView:cell];
    UIButton *directionsButton = [AppHelper buttonWithTag:kTagDirectionsbutton inView:cell];
    
    UIImage *mainImage = [StyleKit drawEstimateCircleImageWithCircleScale:1.0f imageSize:mainImageView.frame.size];
    mainImageView.image = mainImage;
    
    PulsingView *pulsingView = (PulsingView *)[cell viewWithTag:kTagPulsingView];
    [self animatePulsingView:pulsingView];
    
    UIImage *pickerImage = [StyleKit drawImage:DrawingPicker size:CGSizeMake(50, 50)];
    [pickerButton setImage:pickerImage forState:UIControlStateNormal];
    [pickerButton setTitle:nil forState:UIControlStateNormal];
    
    [pickerButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [pickerButton addTarget:self action:@selector(pickerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

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
