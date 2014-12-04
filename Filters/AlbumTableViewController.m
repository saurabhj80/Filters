//
//  AlbumTableViewController.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "AlbumTableViewController.h"


@interface AlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation AlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont fontWithName:@"GillSans-Light" size:26];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    //label.textColor = [UIColor blackColor];
    
    self.navigationItem.titleView = label;
    
    label.text = @"Albums";
    
    [label sizeToFit];

    self.tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.5 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Alert

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender {

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add a new Album" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert textFieldAtIndex:0].keyboardAppearance = UIKeyboardAppearanceDark;
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView resignFirstResponder];
    
    if (buttonIndex == 1 && [[alertView textFieldAtIndex:0].text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]].length != 0) {
     
        id delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext * context = [delegate managedObjectContext];
        
        Album* album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
        
        album.name = [alertView textFieldAtIndex:0].text;
        album.date = [NSDate date];
        
        NSError* error = nil;
        
        if (![context save:&error]) {
            
            NSLog(@"%@", error);
        }
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
