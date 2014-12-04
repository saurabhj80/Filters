//
//  AlbumTableViewController.h
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
