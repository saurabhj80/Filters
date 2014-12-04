//
//  PhotosCollectionViewController.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "Photo.h"
#import "CoreDataHelper.h"

@interface PhotosCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray* photos;

@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"photocell";

-(NSMutableArray *)photos
{
    if (!_photos) {
        
        _photos = [@[] mutableCopy];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSSet* unsortedphotos = self.album.photos;
    NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    NSArray* array = [unsortedphotos sortedArrayUsingDescriptors:@[sort]];
    
    self.photos = [array mutableCopy];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Camera

- (IBAction)cameraButtonPresses:(UIBarButtonItem *)sender
{
    UIImagePickerController* pickImage = [[UIImagePickerController alloc] init];
    pickImage.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        
        pickImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }
    
    [self presentViewController:pickImage animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = info[UIImagePickerControllerEditedImage];
    
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Helper method - Saving Photo to CoreData

-(Photo *)photoFromImage:(UIImage *)image
{
    Photo* photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[CoreDataHelper managedObjectContext]];
    
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    NSLog(@"%@", photo);
    
    NSError *error = nil;
    
    if (![[photo managedObjectContext] save:&error]) {
        
        NSLog(@"%@", error);
    }
    
    return photo;
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    Photo* photo = self.photos[indexPath.row];
    cell.imageView.image = photo.image;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */


@end
