//
//  DateAndLiftProcessor.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/27/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateAndLiftProcessor : NSObject
{
    //Starting definitions
	NSDate* STARTING_DATE;
    NSString* STARTING_DATE_STRING;
	double BENCH_TRAINING_MAX;
	double SQUAT_TRAINING_MAX;
	double OHP_TRAINING_MAX;
	double DEAD_TRAINING_MAX;
	BOOL UNIT_MODE_LBS;
	BOOL ROUND_FLAG;

    
    
	//for sake of output on title
	NSString* STARTINGBENCH;
	NSString* STARTINGSQUAT;
	NSString* STARTINGOHP;
	NSString* STARTINGDEAD;
    
    
	//Currency definitions
    NSString* CURRENT_LIFT;
	NSString* CURRENT_FREQUENCY;
	int CURRENT_CYCLE;
	int liftTrack;
	int freqTrack;
	double CURRENT_FIRST;
	double CURRENT_SECOND;
	double CURRENT_THIRD;
	NSString* CURRENT_DATE_STRING;
	NSDate* CURRENT_DATE_CAL; //to be parsed and worked to maintain current date (instead of modifying starting_date_string like I was before)
	NSDateFormatter* df; // date format only needs to be declared once. Is not and won't be changing (Unless users really want a changable date format...)
    int patternSize; //size of user specified pattern
}
//c  style enum
typedef enum {Bench, Squat, OHP, Deadlift, REST} Lift;
extern NSString * const FREQ5;
extern NSString * const FREQ3;
extern NSString * const FREQ1;

//functions/methods/setters/getters/blah/blah/blah
- (NSString*) convertToString:(Lift) whichLift;
-(void) setStartingDate:(NSString*) myDate;
-(NSString*) getDate;
-(void) setDate:(NSString*) formattedDate;
-(void) setStartingLifts:(NSString*) startingBench and: (NSString*) startingSquat and: (NSString*) startingOHP;
-(NSString*) getStartingDate;
-(int) getCycle;
-(void) setCycle:(int) myCycle;
-(NSString*) getLiftType;
-(NSString*) getFreq;
//commented moethods
-(double) getBenchTM;
-(double) getSquatTM;
-(double) getOHPTM;
-(double) getDeadTM;
-(BOOL) getUnitMode;
-(NSString*) getStartingBench;
-(NSString*) getStartingSquat;
-(NSString*) getStartingOHP;
-(NSString*) getStartingDead;
-(void) setUnitMode:(NSString*) unitMode;
-(void) setRoundingFlag:(bool) roundFlag;
-(void) parseDateString;
-(void) incrementDay;






@end
