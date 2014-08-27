//  TableDisplay.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TableDisplay.h"

@interface TableDisplay ()

@end

@implementation TableDisplay

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    trainingMaxStreamLabel.text = [NSString stringWithFormat:@"%@",_trainingMaxStream];

    
    //check if a database exists, if not, create one
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"lifts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
    
        
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS LIFTS (liftDate text not null, Cycle integer, Lift text not null, Frequency text not null, First_Lift real, Second_Lift real, Third_Lift real, Training_Max integer, column_lbFlag integer)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
        [self insertData];
        [self getData];
            sqlite3_close(_contactDB);
        
            
    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)insertData //there should be a barbell (maybe) object here.
{
    NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO LIFTS (liftDate, Lift, Frequency) VALUES (\"%@\", \"%@\", \"%@\")",  @"Shit",@"Shit", @"Shit"];
    
    char *error;
    if ( sqlite3_exec(_contactDB, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK)
    {
        trainingMaxStreamLabel.text = @"Values inserted";
    }
    else
    {
        trainingMaxStreamLabel.text = @"Something went fuckin wrong";
    }
    
}

//add a where parameter here where user can specify a where blah = fubar
-(void)getData
{
  
    // Create the query statement to find the correct address based on person ID
    NSString *queryStatement = [NSString stringWithFormat:@"SELECT liftDate FROM LIFTS WHERE Frequency = \"%@\"", @"Shit"];
    
    // Prepare the query for execution
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *one = (char*) sqlite3_column_text(statement, 0);
           
        }
        sqlite3_finalize(statement);
    }
    // Return the found address and mark for autorelease
}











@end