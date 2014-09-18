//
//  MyViewController.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/21/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "AdjustPattern.h"
#import "DatePicker.h"

@interface AdjustPattern ()
- (IBAction)addRestDay:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation AdjustPattern

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableData = [NSMutableArray arrayWithArray:_patternArray];
    self.editing = YES; //always enable editing
    //mutable arrays allow us to add/remove data, which we will need to do
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = self.tableData[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    NSString * buttonTitle = [self.tableData objectAtIndex:indexPath.row];
    if ([buttonTitle  isEqual: @"Rest"])
    {
    [self.tableData removeObjectAtIndex:indexPath.row];
    _errorStream.text = @"";
    }
    else
        _errorStream.text = @"Only rest days may be deleted.";
    // Request table view to reload
    [tableView reloadData];
}


- (IBAction)addRestDay:(id)sender {
    NSString *restDay = @"Rest";
//    NSUInteger dataCount = self.tableData.count;
    if ( self.tableData.count < 7)
    {
        [self.tableData addObject:restDay];
        [self.tableView reloadData];
        _errorStream.text = @"";
    }
    else
        _errorStream.text = @"You may only have up to three rest days.";
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.tableData[sourceIndexPath.row];
    [self.tableData removeObjectAtIndex:sourceIndexPath.row];
    [self.tableData insertObject:stringToMove atIndex:destinationIndexPath.row];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"patternToDateSegue"]){
        DatePicker *controller = (DatePicker *)segue.destinationViewController;
        controller.storedDate = _chosenDate;
        controller.patternArray = self.tableData;
        }
}



@end
