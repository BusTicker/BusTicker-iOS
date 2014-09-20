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

@interface HomeCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeCollectionViewController

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    LOG_FRAME(@"home view", self.view.frame);
    LOG_FRAME(@"collection view", self.collectionView.frame);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.collectionView reloadData];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - User Action
#pragma mark -

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

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // TODO: implement
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
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
    CGSize size = collectionView.frame.size;
    
    LOG_SIZE(@"cell", size);
    
    return collectionView.frame.size;
}

@end
