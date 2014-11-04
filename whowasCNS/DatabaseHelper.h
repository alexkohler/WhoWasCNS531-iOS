//
//  DatabaseHelper.h
//  whowasCNS
//
//  Created by Alexander Kohler on 11/3/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#ifndef whowasCNS_DatabaseHelper_h
#define whowasCNS_DatabaseHelper_h
#import <Foundation/Foundation.h>
#import <sqlite3.h>

#endif
@interface DatabaseHelper : NSObject
{

    NSString *databasePath;
    NSString *status;
    
    
    NSString *firstName;
    NSString *lastName;
    float salary;
    
    
}
    @property (nonatomic) sqlite3 *contactDB;
 //   @property (strong, nonatomic) NSString *databasePath;
 //   @property (strong, nonatomic) IBOutlet UILabel *status;//db status

    -(void)openDB:(bool)yesOrNo;
    -(void) clearDB;
    -(int) getNumberOfCycles;
    -(NSString*) getStartingDate;
    -(double) getTrainingMaxFor: (NSString*) liftType;
    -(BOOL) getUnitModeFromDatabase;
@end