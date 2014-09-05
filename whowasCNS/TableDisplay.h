//
//  TableDisplay.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class DateAndLiftProcessor;


@interface TableDisplay : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *trainingMaxStreamLabel;
    NSString* MODE_FORMAT;
	//DecimalFormat twoDForm = new DecimalFormat("#.##");
	int NUMBER_CYCLES;
	NSString* CURRENT_SELECT_QUERY;
	int lbMode;
	BOOL insertStatus;
	bool changedView; 
	BOOL tableColorToggle;
	NSString* retStringSaver; //for sake of changing views
	NSString* lbmode;
    BOOL kgBooleans[7];
	BOOL lbBooleans[7];
    

    
    DateAndLiftProcessor* Processor;
    
}
typedef enum {DEFAULT_V, BENCH_V, SQUAT_V, OHP_V, DEAD_V, FIVES_V, THREES_V, ONES_V} CURRENT_VIEW;
typedef enum {FIVE, THREE, ONE} CURRENT_FREQ;


//data retrieved from text fields
@property(nonatomic, assign) CURRENT_VIEW individualCV; //for individual view
@property(nonatomic, assign) CURRENT_FREQ individualFreq;
@property(nonatomic) NSString  *trainingMaxStream;
@property(nonatomic) NSInteger benchTM;
@property(nonatomic) NSInteger squatTM;
@property(nonatomic) NSInteger ohpTM;
@property(nonatomic) NSInteger deadTM;
@property(nonatomic) BOOL usingLbs;
@property(nonatomic) BOOL usingRounding;
@property(nonatomic) NSArray *patternArray;

//database properties
-(id) init;
- (IBAction)addEvent;
- (IBAction)getData;
@property(nonatomic) NSString *dateText;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) IBOutlet UILabel *status;//db status
@end