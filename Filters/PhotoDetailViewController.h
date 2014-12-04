//
//  PhotoDetailViewController.h
//  Filters
//
//  Created by Saurabh Jain on 12/4/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface PhotoDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) Photo* photo;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deletePressed:(UIButton *)sender;
@end
