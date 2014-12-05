//
//  PhotoDetailViewController.m
//  Filters
//
//  Created by Saurabh Jain on 12/4/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "Photo.h"
#import "FiltersCollectionViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.imageView.image = self.photo.image;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.destinationViewController isKindOfClass:[FiltersCollectionViewController class]]) {
        
        FiltersCollectionViewController* vc = segue.destinationViewController;
        
        vc.photo = self.photo;
        
        //NSLog(@"%@", vc.photo);
    }
    
}


- (IBAction)addFilterButtonPressed:(UIButton *)sender
{
    
    
}

- (IBAction)deletePressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError * error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
