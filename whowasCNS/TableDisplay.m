 //  TableDisplay.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TableDisplay.h"
#import "DateAndLiftProcessor.h"

@interface TableDisplay ()

@end


@implementation TableDisplay

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        int bar = 5;
        // Custom initialization
    }
    return self;
}

-(id) init
{
    self = [super init];
    if(self)
    {
        insertStatus = NO;
        changedView = NO;
        tableColorToggle = YES;

        for (int i = 0; i < 7; i++){
            kgBooleans[i] = YES;
            lbBooleans[i] = YES;
        }
        
    static CURRENT_VIEW curView = DEFAULT_V;
    Processor  = [[DateAndLiftProcessor alloc] init];
        
        trainingMaxStreamLabel.text = [NSString stringWithFormat:@"%@",_trainingMaxStream];
        
        
        [self openDB:YES];
        [Processor setStartingDate:_dateText];
        [Processor parseDateString];
        [Processor setStartingLifts:_benchTM and:_squatTM and:_ohpTM and:_deadTM];
        [Processor calculateCycle:2 with:_patternArray withDBContext:_contactDB];
        [self getData:@""];
        [self openDB:NO];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self init];
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
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"lifts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:_databasePath];
    
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        if (!databaseAlreadyExists)
        {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS LIFTS (liftDate text not null, Cycle integer, Lift text not null, Frequency text not null, First_Lift real, Second_Lift real, Third_Lift real, Training_Max integer, column_lbFlag integer)";
        
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
        }
        
        if (!yesOrNo)
            sqlite3_close(_contactDB);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)addEvent
{
    //WILL PROBABLY HAVE TO OPEN DATABASE TO INSERT**)(*)(*&*(&^(*&(*&^(*&^(*&^(*&^(*&^(*&^
   ( values.put(EventsDataSQLHelper.LIFTDATE, thirdScreen.Processor.getDate() );
    values.put(EventsDataSQLHelper.CYCLE, thirdScreen.Processor.getCycle());
    values.put(EventsDataSQLHelper.LIFT, thirdScreen.Processor.getLiftType());
    values.put(EventsDataSQLHelper.FREQUENCY, thirdScreen.Processor.getFreq());
    values.put(EventsDataSQLHelper.FIRST, thirdScreen.Processor.getFirstLift());
    values.put(EventsDataSQLHelper.SECOND, thirdScreen.Processor.getSecondLift());
    values.put(EventsDataSQLHelper.THIRD, thirdScreen.Processor.getThirdLift());
    
    
    NSString* currentDate = [Processor getDate];
	int currentCycle = [Processor getCycle];
    NSString* currentLift = [Processor getLiftType];
    NSString* currentFreq = [Processor getFreq];
    double firstLift = [Processor getFirstLift];
    double secondLift = [Processor getSecondLift];
	double thirdLift = [Processor getThirdLift];
    NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO LIFTS (liftDate, Cycle, Lift, Frequency, firstLift, secondLift, thirdLift) VALUES (\"%@\", \"%i\", \"%@\", \"%@\", \"%g\", \"%g\", \"%g\")",  currentDate, currentCycle, currentLift, currentFreq, firstLift, secondLift, thirdLift];
    
    char *error;
    if ( sqlite3_exec(_contactDB, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK)
    {
        trainingMaxStreamLabel.text = @"Values inserted";
    }
    else
    {
        trainingMaxStreamLabel.text = @"Something went fuckin wrong";
    }
    
}*/


-(void)getData:(NSString*)whereClause
{	NSString *queryStatement = @"SELECT * FROM lifts";
    // You're gonna have to mess with whereclause syntax, may not just be a simple string like it was in android
	//liftDate text not null, Cycle integer, Lift text not null, Frequency text not null, First_Lift real, Second_Lift real, Third_Lift real, Training_Max integer, column_lbFlag integer
    if (![whereClause isEqualToString:@""])//if we do not have an empty query
    {
        queryStatement = [queryStatement stringByAppendingString:@" "];
        queryStatement = [queryStatement stringByAppendingString:whereClause];
    }
	
	
    // Prepare the query for execution
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
		{
			
            char *liftDate = (char*) sqlite3_column_text(statement, 0);
			int cycle = sqlite3_column_int(statement, 1);
			char *liftType = (char*) sqlite3_column_text(statement, 2);
			char *frequency = (char*) sqlite3_column_text(statement, 3);
			double firstlift = (double) sqlite3_column_double(statement, 4);
			double secondlift = (double) sqlite3_column_double(statement, 5);
			double thirdlift = (double) sqlite3_column_double(statement, 6);
			
			//these may be able to go into a single statement
            
			NSString *liftDateString   = [NSString stringWithUTF8String:liftDate];
			NSString* cycleString 	   = [NSString stringWithFormat:@"%i", cycle];
			NSString *liftTypeString   = [NSString stringWithUTF8String:liftType];
			NSString *frequencyString  = [NSString stringWithUTF8String:frequency];
			NSString* firstliftString  = [NSString stringWithFormat:@"%g", firstlift];
			NSString* secondliftString = [NSString stringWithFormat:@"%g", secondlift];
			NSString* thirdliftString  = [NSString stringWithFormat:@"%g", thirdlift];
			
			//training max is also something you will need to worry about for when you start supporting view existing database
			//createColumn:liftDate withCycle:cycle liftType:liftType freq:frequency first:firstlift second:secondlift third:thirdlift; //either createColumn or a addToBuffer method or the like
		}
        sqlite3_finalize(statement);
    }
}











@end
