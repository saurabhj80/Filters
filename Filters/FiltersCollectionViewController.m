//
//  FiltersCollectionViewController.m
//  Filters
//
//  Created by Saurabh Jain on 12/4/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "FiltersCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface FiltersCollectionViewController ()

@property (strong, nonatomic) NSMutableArray* filters;
@property (strong, nonatomic) CIContext * context;

@end

@implementation FiltersCollectionViewController

-(NSMutableArray *)filters
{
    
    if (!_filters) _filters = [[NSMutableArray alloc] init];
    
    return _filters;
    
}

-(CIContext *)context
{
    
    if (!_context) _context = [CIContext contextWithOptions:nil];
    
    return _context;
    
}

static NSString * const reuseIdentifier = @"filter cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.filters = [[[self class] photoFilters] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Filters

+ (NSArray *)photoFilters;

{
    
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, @1, nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: nil];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    
    CIFilter *colorControl = [CIFilter filterWithName:@"CIColorControls" keysAndValues: kCIInputSaturationKey, @0.5, nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: nil];
    
    NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControl, transfer, unsharpen, monochrome];
    
    return allFilters;
    
}

#pragma mark - Helper

- (UIImage *)applyPhotoWithFilter:(UIImage *)image withFilter:(CIFilter *)filter
{
    
    CIImage* unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    CIImage* filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef final = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage* finalImage = [UIImage imageWithCGImage:final];
    
    return finalImage;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [self.filters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    
    dispatch_queue_t FilterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(FilterQueue, ^{
        
        UIImage * image = [self applyPhotoWithFilter:self.photo.image withFilter:self.filters[indexPath.row]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = image;
        });
        
    });
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell* cell = (PhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = cell.imageView.image;
    
    if (self.photo.image) {
        
        
        NSError *error = nil;
        
        if ([[self.photo managedObjectContext] save:&error]) {
            
            NSLog(@"%@", error);
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
