 //  TableDisplay.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TableDisplay.h"
#import "DateAndLiftProcessor.h"
#import "TableDisplayCell.h"
@interface TableDisplay ()

@end


@implementation TableDisplay

@synthesize dates = _dates;
@synthesize cycles = _cycles;
@synthesize firstLifts = _firstLifts;
@synthesize secondLifts = _secondLifts;
@synthesize thirdLifts = _thirdLifts;
@synthesize typeFreqs = _typeFreqs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        insertStatus = NO;
        changedView = NO;
        tableColorToggle = YES;
        self.dates = [[NSMutableArray alloc] init]; //initialize our date array
        self.cycles = [[NSMutableArray alloc] init];
        self.firstLifts = [[NSMutableArray alloc] init];
        self.secondLifts  = [[NSMutableArray alloc] init];
        self.thirdLifts = [[NSMutableArray alloc] init];
        self.typeFreqs = [[NSMutableArray alloc] init];
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
        [Processor calculateCycle:_numberOfCycles with:_patternArray withDBContext:_contactDB];
//        [self getData:@""];
        [self populateArrays]; //initialize our date array
        [self openDB:NO];
        // Custom initialization
    }
    return self;
}

-(id) init
{
    self = [super init];
    if(self)
    {
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self init];
    //self.dates = [NSArray arrayWithObjects:@"9-01: Bench Triples: 430 440 450", @"9-02 Squat 5-3-1 120 140 170", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
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

//fix your loop initialization stuff
-(void)populateArrays
{	NSString *queryStatement = @"SELECT * FROM lifts";

	
    // Prepare the query for execution
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
		{
			//date
            char *liftDate = (char*) sqlite3_column_text(statement, 0);
            NSString *liftDateString   = [NSString stringWithUTF8String:liftDate];
            [self.dates addObject:liftDateString];
            
            //cycle
            int cycle = sqlite3_column_int(statement, 1);
            NSString* cycleString = [NSString stringWithFormat:@"Cycle: %i", cycle];
            [self.cycles addObject:cycleString];
            
            //lift type
            char *liftType = (char*) sqlite3_column_text(statement, 2);
            NSString *liftTypeString   = [NSString stringWithUTF8String:liftType];

            NSString* liftBuffer;
            
            //first ,second, third lift
            double firstlift = (double) sqlite3_column_double(statement, 4);
            double secondlift = (double) sqlite3_column_double(statement, 5);
			double thirdlift = (double) sqlite3_column_double(statement, 6);
            NSString* firstliftString;
            NSString* secondliftString;
            NSString* thirdliftString;
        char *frequency = (char*) sqlite3_column_text(statement, 3);
        NSString *frequencyString  = [NSString stringWithUTF8String:frequency];
            
            //may want to refactor and break this into another method 
          if ([frequencyString isEqualToString:@"5-5-5"])
          {
              firstliftString  = [NSString stringWithFormat:@"%gx5", firstlift];
              secondliftString = [NSString stringWithFormat:@"%gx5", secondlift];
              thirdliftString =  [NSString stringWithFormat:@"%gx5", thirdlift];
              liftBuffer = [NSString stringWithFormat:@"%@ - 5-5-5", liftTypeString];
          }
            else if ([frequencyString isEqualToString:@"3-3-3"])
            {
                firstliftString  = [NSString stringWithFormat:@"%gx3", firstlift];
                secondliftString = [NSString stringWithFormat:@"%gx3", secondlift];
                thirdliftString =  [NSString stringWithFormat:@"%gx3", thirdlift];
              liftBuffer = [NSString stringWithFormat:@"%@ - 3-3-3", liftTypeString];
            }
            
            else if ([frequencyString isEqualToString:@"5-3-1"])
            {
                firstliftString  = [NSString stringWithFormat:@"%gx5", firstlift];
                secondliftString = [NSString stringWithFormat:@"%gx3", secondlift];
                thirdliftString =  [NSString stringWithFormat:@"%gx1", thirdlift];
                liftBuffer = [NSString stringWithFormat:@"%@ - 5-3-1", liftTypeString];
            }
            
            [self.firstLifts addObject:firstliftString];
            [self.secondLifts addObject:secondliftString];
            [self.thirdLifts addObject:thirdliftString];
            [self.typeFreqs addObject:liftBuffer];
            
			
		}
        sqlite3_finalize(statement);
    }
}





//table display methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //A complete cycle is 12 lifts - 4 5-5-5s, 4 3-3-3s, and 4 5-3-1s
    return (_numberOfCycles * 12);
}


/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _numberOfCycles;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EntryCell";
    
    TableDisplayCell *cell = [tableView
                                    dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableDisplayCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.date.text = [self.dates
                      objectAtIndex:[indexPath row]];
    cell.cycle.text = [self.cycles
                       objectAtIndex:[indexPath row]];
    cell.liftOne.text = [self.firstLifts objectAtIndex:[indexPath row]];
    cell.liftTwo.text = [self.secondLifts objectAtIndex:[indexPath row]];
    cell.liftThree.text = [self.firstLifts objectAtIndex:[indexPath row]];
    cell.typeFreq.text = [self.typeFreqs objectAtIndex:[indexPath row]];
    return cell;
}









@end
