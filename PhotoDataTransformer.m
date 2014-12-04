//
//  PhotoDataTransformer.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "PhotoDataTransformer.h"

@implementation PhotoDataTransformer

+(Class)transformedValueClass{
    
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
    
}

-(id)reverseTransformedValue:(id)value
{
    
    return [UIImage imageWithData:value];
}

@end
