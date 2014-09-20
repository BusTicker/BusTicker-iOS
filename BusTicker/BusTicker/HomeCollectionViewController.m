//
//  HomeCollectionViewController.m
//  BusTicker
//
//  Created by Brennan Stehling on 9/20/14.
//  Copyright (c) 2014 BusTicker. All rights reserved.
//

#import "HomeCollectionViewController.h"

@interface HomeCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeCollectionViewController

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // TODO: implement
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
    // dequeue named cell template
    return nil;
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: implement
    NSLog(@"Selected item!");
}

@end
