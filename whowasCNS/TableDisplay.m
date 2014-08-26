//
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
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
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
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void) insertData
//{
//    sqlite3 *database;
//    const char *dbPath= [ _databasePath UTF8String];
//    if(sqlite3_open(dbPath,&database)==SQLITE_OK)
//    {
//        const char *sqlstatement = "INSERT INTO upssTable (column1, column2) VALUES (?,?)";
//        sqlite3_stmt *compiledstatement;
//        
//        if(sqlite3_prepare_v2(database,sqlstatement , -1, &compiledstatement, NULL)==SQLITE_OK)
//        {
//            NSString *  str1 =@"1";
//            NSString * str2 =@"1";
//            sqlite3_bind_int(compiledstatement, 1, [str1 integerValue]);
//            sqlite3_bind_int(compiledstatement, 2, [str2 integerValue]);
//            if(sqlite3_step(compiledstatement)==SQLITE_DONE)
//            {
//                NSLog(@"done");
//            }
//            else NSLog(@"ERROR");
//            sqlite3_reset(compiledstatement);
//        }
//        else
//        {
//            NSAssert1(0, @"Error . '%s'", sqlite3_errmsg(cruddb));
//        }
//        sqlite3_close(database);
//    }
//}








@end
