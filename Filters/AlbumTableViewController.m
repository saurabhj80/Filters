//
//  AlbumTableViewController.m
//  Filters
//
//  Created by Saurabh Jain on 12/3/14.
//  Copyright (c) 2014 Saurabh jain. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "CoreDataHelper.h"
#import "PhotosCollectionViewController.h"


@interface AlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation AlbumTableViewController

-(NSMutableArray *)albums
{
    if (!_albums) {
        
        _albums = [[NSMutableArray alloc] init];
    }
    
    return _albums;
}

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
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.25 blue:0.35 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSManagedObjectContext* context = [CoreDataHelper managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Album" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    self.albums = [fetchedObjects mutableCopy];
    
    if (fetchedObjects == nil) {
        
        NSLog(@"Nil");
    }
    
    [self.tableView reloadData];
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
        
        [self.albums addObject:[self albumWithName:[alertView textFieldAtIndex:0].text]];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.albums count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

#pragma mark - Helper method

-(Album *)albumWithName:(NSString*)name
{
    NSManagedObjectContext * context = [CoreDataHelper managedObjectContext];
    
    Album* album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    album.name = name;
    album.date = [NSDate date];
    
    NSError* error = nil;
    
    if (![context save:&error]) {
        
        NSLog(@"%@", error);
    }
    
    return album;
    
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
    
    Album *a = self.albums[indexPath.row];
    cell.textLabel.text = a.name;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"GillSans-Light" size:24];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.tableView.rowHeight = UITableViewAutomaticDimension;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"albumChosen"]){
        
        if ([segue.destinationViewController isKindOfClass:[PhotosCollectionViewController class]]) {
            
            PhotosCollectionViewController* vc = segue.destinationViewController;
            
            NSIndexPath * path = [self.tableView indexPathForSelectedRow];
            
            vc.album = self.albums[path.row];
            
            //NSLog(@"album");
        }
    }
    
}


@end
