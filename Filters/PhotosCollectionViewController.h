//
//  PhotosCollectionViewController.h
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionViewCell.h"
#import "Album.h"

@interface PhotosCollectionViewController : UICollectionViewController

@property (strong,nonatomic) Album* album;

- (IBAction)cameraButtonPresses:(UIBarButtonItem *)sender;

@end
