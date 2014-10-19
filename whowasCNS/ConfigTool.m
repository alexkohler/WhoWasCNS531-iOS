//
//  ConfigTool.m
//  whowasCNS
//
//  Created by Alexander Kohler on 10/17/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ConfigTool.h"
@implementation  ConfigTool

-(NSString*) incrementCal:(NSDate*)CURRENT_DATE_CAL withDays:(int) days
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    CURRENT_DATE_CAL = [theCalendar dateByAddingComponents:dayComponent toDate:CURRENT_DATE_CAL options:0];
    NSDateFormatter* df;
    [df setDateFormat:@"MM-dd-yyyy"];
    //format date here...
    CURRENT_DATE_STRING = [df stringFromDate:CURRENT_DATE_CAL];
    return CURRENT_DATE_STRING;
}

-(void) setDate:(NSString*) formattedDate
{
    CURRENT_DATE_STRING = formattedDate;
}

-(NSArray*) getNextLift:(NSDate*) c1 withPattern:(NSArray*) myPattern andCurrentLift:(NSString*) currentLift withMode:(NSString*) viewMode
{
    //String[] myPattern = {"Squat", "Rest", "Bench", "Deadlift", "Rest", "OHP"  };
    //each case: getnextliftfunctiondefault that finds the lift we are at case of, gets the column index,
    //increments (or decrements) that column indexes WHILE incrementing or decrementing the day until it runs into a day that isn't rest.
    //returns a 2 dimensioned array, with the first value being nextLift and the second value being incremented string
    //dirty data that I probably should have cleaned up earlier
    if ([currentLift containsString:@"OHP"])
        currentLift = @"OHP";
    else if ([currentLift containsString:@"Bench"])
        currentLift = @"Bench";
    else if ([currentLift containsString:@"Squat"])
        currentLift = @"Squat";
    else if ([currentLift containsString:@"Dead"])
        currentLift = @"Deadlift";

    if ([viewMode isEqualToString:@"BENCH"] || [viewMode isEqualToString:@"SQUAT"] || [viewMode  isEqualToString:@"DEAD"] || [viewMode isEqualToString:@"OHP"] )
    {
        
        NSString* incrementedString =  [self incrementCal:c1 withDays:[myPattern count]];
        NSArray* resultsForward = @[currentLift, incrementedString];
        return resultsForward;
    }
    
    
    
    int i = 0;
    //find our column index of our current lift...
    
    while (![myPattern[i] isEqualToString:currentLift])
          i++;
    //we need to increment at least once, but there may be more than one rest day we we have loop implemented..
    int j = i + 1;//set a new incrementer for i
    NSString* incrementedString = [self incrementCal:c1 withDays:1];
    
    if (j >=  [myPattern count]){ //may not need second declaration?
        j = 0;
        if ([viewMode isEqualToString:@"FIVES"] || [viewMode isEqualToString:@"THREES"] || [viewMode isEqualToString:@"ONES"])
            incrementedString = [self incrementCal:c1 withDays:(2 * [myPattern count])];//we must run thorugh cycle twice if we break forward or backward through our array indexes
    }
    while ([myPattern[j] isEqualToString:@"Rest"]) //while loop is here to take into account multiple rest days
    {
        j++;
        incrementedString = [self incrementCal:c1 withDays:1];
        if (j >= [myPattern count] )
        {
            j = 0; //go back to beginnig
            if ([viewMode isEqualToString:@"FIVES"] || [viewMode isEqualToString:@"THREES"] || [viewMode isEqualToString:@"ONES"])
                incrementedString = [self incrementCal:c1  withDays:(2 * [myPattern count])];//we must run thorugh cycle twice if we break forward or backward through our array indexes
        }
    }
    //assert: if we broke out of this loop then myPattern[j] is NOT a rest day, and hence our next lift
    NSString* nextLift = myPattern[j];
    
    NSArray* resultsForward = @[nextLift, incrementedString];
    return resultsForward;
}


-(void)openDB:(bool)yesOrNo withContactDB:(sqlite3*) contactDB 
//might be able to remove dbpath param
{
    //check if a database exists, if not, create one
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
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
    
        if (!yesOrNo)
        {
            sqlite3_close(contactDB);
        }
    }
}



//why is lbMode not used?

-(NSArray*) configureNextSetWithDate:(NSString*) myDate withLift:(NSString*)myNextLift withView:(NSString*)viewMode /*withUnitMode:(NSString*)lbMode*/ withPattern:(NSArray*) pattern withContactDB:(sqlite3*) contactDB withRounding:(BOOL) usingRounding
{
    sqlite3_stmt *statement;
    char *liftDate;
    NSString *liftDateString;
    int cycle;
    NSString* cycleString;
    char *liftType;
    NSString *liftTypeString;
    NSString* liftBuffer;
    double firstlift;
    double secondlift;
    double thirdlift;
    NSString* firstliftString;
    NSString* secondliftString;
    NSString* thirdliftString;
    char *frequency;
    NSString *frequencyString;
    
    
    
    NSString* queryStatement = [NSString stringWithFormat:@"SELECT * FROM LIFTS WHERE liftDate = '%@' AND Lift = '%@'", myDate, myNextLift];
    // NEED TO WORRY ABOUT EDGE CASES - see how ios sqlite3 handles a bad query
    
    if (sqlite3_prepare_v2(contactDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Create a new address from the found row
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //date
            liftDate = (char*) sqlite3_column_text(statement, 0);
            liftDateString = [NSString stringWithUTF8String:liftDate];
      
            //cycle
            cycle = sqlite3_column_int(statement, 1);
            cycleString = [NSString stringWithFormat:@"Cycle: %i", cycle];
     
            //lift type
            liftType = (char*) sqlite3_column_text(statement, 2);
            liftTypeString = [NSString stringWithUTF8String:liftType];
            //first ,second, third lift
            firstlift = (double) sqlite3_column_double(statement, 4);
            secondlift = (double) sqlite3_column_double(statement, 5);
            thirdlift = (double) sqlite3_column_double(statement, 6);
            frequency = (char*) sqlite3_column_text(statement, 3);
            frequencyString = [NSString stringWithUTF8String:frequency];
            //may want to refactor and break this into another method
            if ([frequencyString isEqualToString:@"5-5-5"])
            {
                if (usingRounding) //change me to proper logic
                {
                    firstliftString = [NSString stringWithFormat:@"%gx5", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%gx5", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%gx5", thirdlift];
                }
                else
                {
                    firstliftString = [NSString stringWithFormat:@"%.2fx5", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%.2fx5", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%.2fx5", thirdlift];
                }
                liftBuffer = [NSString stringWithFormat:@"%@ - 5-5-5", liftTypeString];
            }
            else if ([frequencyString isEqualToString:@"3-3-3"])
            {
                if (usingRounding)
                {
                    firstliftString = [NSString stringWithFormat:@"%gx3", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%gx3", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%gx3", thirdlift];
                }
                else
                {
                    firstliftString = [NSString stringWithFormat:@"%.2fx3", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%.2fx3", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%.2fx3", thirdlift];
                }
                liftBuffer = [NSString stringWithFormat:@"%@ - 3-3-3", liftTypeString];
            }
            else if ([frequencyString isEqualToString:@"5-3-1"])
            {
                if (usingRounding)
                {
                    firstliftString = [NSString stringWithFormat:@"%gx5", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%gx3", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%gx1", thirdlift];
                }
                else
                {
                    firstliftString = [NSString stringWithFormat:@"%.2fx5", firstlift];
                    secondliftString = [NSString stringWithFormat:@"%.2fx3", secondlift];
                    thirdliftString = [NSString stringWithFormat:@"%.2fx1", thirdlift];
                }
                liftBuffer = [NSString stringWithFormat:@"%@ - 5-3-1", liftTypeString];
            }
          
          
       
        }
        sqlite3_finalize(statement);
    }

    //what do we need to return?
   /* _dateLabel.text = _date;
    _typeFreqLabel.text = _typeFreq;
    _liftOneLabel.text = _liftOne;
    _liftTwoLabel.text = _liftTwo;
    _liftThreeLabel.text = _liftThree;
    _cycleLabel.text = _cycle;*/

    NSArray* resultsForward = @[liftDateString, frequencyString, firstliftString, secondliftString, thirdliftString, cycleString];
    return resultsForward;

}



@end