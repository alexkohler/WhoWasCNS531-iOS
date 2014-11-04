//
//  DatabaseHelper.m
//  whowasCNS
//
//  Created by Alexander Kohler on 11/3/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"
@implementation  DatabaseHelper
/*
- (id)initWithFirstName:(NSString *)aFirstName
               lastName:(NSString *)aLastName
                 salary:(float)aSalary
{
    if( self = [super init] )
    {
        firstName = aFirstName;
        lastName = aLastName;
        salary = aSalary;
    }
    
    return self;
}*/


-(id) initWithDatabasePath:(NSString*) aDatabasePath
{
    if( self = [super init] )
    {
        databasePath = aDatabasePath;
    }
    
    return self;
}




-(void)openDB:(bool)yesOrNo
{
    //check if a database exists, if not, create one
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"lifts.db"]];
    
    
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        if (!databaseAlreadyExists)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS LIFTS (liftDate text not null, Cycle integer, Lift text not null, Frequency text not null, First_Lift real, Second_Lift real, Third_Lift real, Training_Max integer, column_lbFlag integer)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                status = @"Failed to create table";
            }
        }
        
        if (!yesOrNo)
            sqlite3_close(_contactDB);
        
    }
}


-(void) clearDB
{
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        const char *sql = "DELETE FROM lifts";
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(_contactDB, sql,-1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_DONE){
                // executed
            }else{
                NSLog(@"%s",sqlite3_errmsg(_contactDB));
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(_contactDB);
}

-(BOOL) getUnitModeFromDatabase //sanity check after nightmare bug with android
{
    NSString *queryStatement = @"SELECT column_lbFlag FROM Lifts ORDER BY ROWID ASC LIMIT 1";
    
    sqlite3_stmt *statement;
    int cycle = 1; // In case anything goes wrong, just use lbs
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            cycle = sqlite3_column_int(statement, 0);
            
        }
        sqlite3_finalize(statement);
    }
    
    if (cycle == 0)
        return NO;
    else
        return YES;
}

-(double) getTrainingMaxFor: (NSString*) liftType
{
    NSString *queryStatement = [NSString stringWithFormat:@"SELECT Training_Max FROM Lifts where Lift = '%@' ORDER BY ROWID ASC LIMIT 1", liftType];
    
    sqlite3_stmt *statement;
    double tm = 1; // In case anything goes wrong, just use lbs
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            tm = sqlite3_column_int(statement, 0);
            
        }
        sqlite3_finalize(statement);
    }
    
    if (tm == 0)
        NSLog(@"An error occured getting the training max for one of the lifts. (String format laziness before you ask)");
    
    return tm;
}

-(NSString*) getStartingDate
{
    NSString *queryStatement = @"SELECT liftDate FROM Lifts ORDER BY ROWID ASC LIMIT 1";
    
    sqlite3_stmt *statement;
    NSString* tmString;
    const unsigned char *tm; // In case anything goes wrong, just use lbs
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            tm = sqlite3_column_text(statement, 0);
            tmString = [[NSString alloc] initWithUTF8String:(char *)tm];
        }
        sqlite3_finalize(statement);
    }
    
        
    if ([tmString isEqualToString:@""])
        NSLog(@"An error occured getting the training max for one of the lifts. (String format laziness before you ask)");
    
    return tmString;

}


-(int) getNumberOfCycles
{
    NSString *queryStatement = @"select Cycle From Lifts ORDER BY ROWID DESC LIMIT 1";
    
    sqlite3_stmt *statement;
    int numberOfCycles = 1; // In case anything goes wrong, just use lbs
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            numberOfCycles = sqlite3_column_int(statement, 0);
            
        }
        sqlite3_finalize(statement);
    }
    
    return numberOfCycles;
}



/*Schema definition
 
 7|Training_Max|integer|0||0
 8|column_lbFlag|integer|0||0
 
 */



/*
 controller.dateText = @"3/19/14"; //this will be the first date entry
    //SELECT liftDate FROM Lifts ORDER BY ROWID ASC LIMIT 1;
 
 
 controller.usingRounding = @"NO"; //for now, just leave this but either prompt user or leave it at one or the other.
 
 controller.usingLbs = @"YES"; //refer to lbflag column
        SELECT column_lbFlag FROM Lifts ORDER BY ROWID ASC LIMIT 1;
 controller.benchTM = 300; //refer to training max column
        select Training_Max from lifts where lift = 'Bench' order by rowid asc limit 1;
 controller.squatTM = 350; // ""
        select Training_Max from lifts where lift = 'Squat' order by rowid asc limit 1;
controller.ohpTM = 185;   // ""
        select Training_Max from lifts where lift = 'OHP' order by rowid asc limit 1;
 controller.deadTM = 405;  // ""
       select Training_Max from lifts where lift = 'Deadlift' order by rowid asc limit 1;
 
 
 
 [Training max column is not being used...?] dh needs another method
 
 
 controller.numberOfCycles = 1; // "" select highest in Cycle column
*/


@end

