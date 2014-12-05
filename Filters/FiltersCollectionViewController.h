//
//  FiltersCollectionViewController.h
//  Filters
//
//  Created by Saurabh Jain on 12/4/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Photo;

@interface FiltersCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Photo* photo;

@end
