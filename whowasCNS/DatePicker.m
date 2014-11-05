//
//  DatePicker.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/12/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "DatePicker.h"
#import "TrainingMaxes.h"
#import "AdjustPattern.h"
#import "GAI.h"
#import "GAITrackedViewController.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "DatabaseHelper.h"
#import "TableDisplay.h"

@implementation DatePicker
-(IBAction)displayDate:(id)sender {
    pickerDate = [picker date];
	}

- (void)viewDidLoad {
	NSDate *now = [NSDate date];
	[picker setDate:now animated:YES];
	
    [existingProjectionErrorText setHidden:YES];
    //if user is coming from pattern segue
   if (_storedDate != nil )
       [picker setDate:_storedDate];
   
    //if user didn not specify a custom pattern 
    if (_patternArray == nil)
        _patternArray = @[@"Bench",@"Squat",@"Rest",@"OHP",@"Deadlift", @"Rest"];
    else
    currentPatternField.text = [[_patternArray valueForKey:@"description"] componentsJoinedByString:@" - "];
    
}
//Analytics
- (void)viewWillAppear:(BOOL)animated {
     self.screenName = @"Home Screen"; // set screenName prior to calling super
    [super viewWillAppear:animated];
   }

-(NSString *)formatDate:(NSString *)initialDate;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    pickerDate  = [dateFormatter dateFromString:initialDate];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:pickerDate];
    return newDate;
}

-(NSString *)formatDateDate:(NSDate *)initialDate;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];//change locale bullshit
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSString* result = [dateFormatter stringFromDate:initialDate];
    return result;
   }

-(bool) liftsTableExists
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    NSString* databasePath = [[NSString alloc]
                              initWithString: [docsDir stringByAppendingPathComponent:
                                               @"lifts.db"]];
        const char *dbpath = [databasePath UTF8String];
    
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    int entryCount = 0;
    if (databaseAlreadyExists)
    {
        if(sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            NSString *sql = @"select count(*) from Lifts";
            const char *utfsql = [sql UTF8String];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(_contactDB, utfsql,-1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_prepare_v2(_contactDB, utfsql, -1, &statement, NULL) == SQLITE_OK)
                {
                    // Create a new address from the found row
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        entryCount = sqlite3_column_int(statement, 0);
                    }
                }
            }
            sqlite3_finalize(statement);
        }
    sqlite3_close(_contactDB);
    }
    
    if (entryCount > 0){
        NSLog(@"Table exists");
        return true;
        }
    else{
        NSLog(@"Table does not exist");
        return false;
    }
    
}

-(IBAction)viewExistingProjection:(id)sender
{
    if ([self liftsTableExists])
        [self performSegueWithIdentifier:@"existingProjectionSegue" sender:sender];
    else
        [existingProjectionErrorText setHidden:NO];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"dateToTMSegue"]){
        TrainingMaxes *controller = (TrainingMaxes *)segue.destinationViewController;
//        pickerDateString = [picker description];
        //NSString *title = [NSString stringWithFormat:@"Starting Date: %@", pickerDateString];
        controller.dateText = [self formatDateDate:[picker date]];
        controller.patternArray = _patternArray; //Simply passing patternArray down the line
    }
    
    if([segue.identifier isEqualToString:@"dateToPatternSegue"]){
        //pass date back here - declare properties here and at pattern.m, implement a prepareForSegue method over at :: as well.
        AdjustPattern *patternController = (AdjustPattern *)segue.destinationViewController;
        patternController.chosenDate = [picker date];
        patternController.patternArray = _patternArray;
    }
    
    if([segue.identifier isEqualToString:@"existingProjectionSegue"]){
        DatabaseHelper *dh = [[DatabaseHelper alloc]init];
        [dh openDB:YES];
        TableDisplay *controller = (TableDisplay *) segue.destinationViewController;
        NSString* dateText = [dh getStartingDate];
        controller.dateText = dateText;
        NSString* modeString = @"NO";//get this from database eventually
        controller.usingRounding = modeString;
        bool usingLbs =  [dh getUnitModeFromDatabase];
        controller.usingLbs = usingLbs;
        int benchTM = [dh getTrainingMaxFor:@"Bench"];
        int squatTM = [dh getTrainingMaxFor:@"Squat"];
        int ohpTM = [dh getTrainingMaxFor:@"OHP"];
        int deadTM = [dh getTrainingMaxFor:@"Deadlift"];
        NSString *unitString;
        unitString = usingLbs ? @"Mode: Lbs" : @"Mode: Kgs";
        
        //Open the breakpoints window (Run – Show – Breakpoints) and add two symbolic breakpoints called “objc_exception_throw” and “[NSException raise]"
        NSString *existingProjectionTitle = [NSString stringWithFormat:@"Starting TMS Bench[%i] Squat[%i], OHP[%i], Dead[%i] Rounding? [%@] %@", benchTM, squatTM, ohpTM, deadTM, modeString, unitString];
        controller.benchTM = benchTM;
        controller.squatTM = squatTM;
        controller.ohpTM = ohpTM;
        controller.deadTM = deadTM;
        controller.numberOfCycles = [dh getNumberOfCycles];
        controller.patternArray = _patternArray;
        controller.contactDB = _contactDB;
        [dh openDB:NO];
        

                

        
        controller.trainingMaxStream = existingProjectionTitle;

        }
}




 
@end
