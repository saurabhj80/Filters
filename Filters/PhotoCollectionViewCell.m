//
//  PhotoCollectionViewCell.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
    
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
    
}


-(void)setup
{
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 5, 5)];
    
    [self.contentView addSubview:self.imageView];
    
}

@end
