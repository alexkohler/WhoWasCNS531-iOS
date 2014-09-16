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
	NSString* CURRENT_SELECT_QUERY;
	int lbMode;
	BOOL insertStatus;
	bool changedView; 
	BOOL tableColorToggle;
	NSString* retStringSaver; //for sake of changing views
	NSString* lbmode;
    BOOL kgBooleans[7];
	BOOL lbBooleans[7];
    BOOL init;
    IBOutlet UILabel *label_Date;
      DateAndLiftProcessor* Processor;
    IBOutlet UITableView * liftTableView;
}
typedef enum {DEFAULT_V, BENCH_V, SQUAT_V, OHP_V, DEAD_V, FIVES_V, THREES_V, ONES_V} CURRENT_VIEW;
typedef enum {FIVE, THREE, ONE} CURRENT_FREQ;


//to populate tables
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NSMutableArray *cycles;
@property (nonatomic, strong) NSMutableArray *typeFreqs;
@property (nonatomic, strong) NSMutableArray *firstLifts;
@property (nonatomic, strong) NSMutableArray *secondLifts;
@property (nonatomic, strong) NSMutableArray *thirdLifts;


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
@property(nonatomic) NSInteger numberOfCycles;
//database properties
-(id) init;
- (IBAction)addEvent;
- (IBAction)getData;
-(IBAction) showConfigMenu;
@property(nonatomic) NSString *dateText;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) IBOutlet UILabel *status;//db status
@end