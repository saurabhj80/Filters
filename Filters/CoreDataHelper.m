//
//  CoreDataHelper.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper


+(NSManagedObjectContext *)managedObjectContext
{
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = nil;
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end
