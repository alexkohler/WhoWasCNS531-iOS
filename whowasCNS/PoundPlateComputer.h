//
//  PoundPlateComputer.h
//  whowasCNS
//
//  Created by Alexander Kohler on 9/1/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoundPlateComputer : NSObject
{
    bool lb_mode;
    
    
    //weight entered
	double weight;
    
	//weight not including bar
	double plateWeight;
    
    
	//weight remaining (for sanity checks and more readable calculation
    
	int fortyfivesNeeded;
	int thirtyfivesNeeded;
	int twentyfivesNeeded;
	int tensNeeded;	int fivesNeeded;
	int twopointfivesNeeded;
    
	int currentPlate_needed;
	NSString* currentPlateName;
}

-(double) getWeight;
-(double) round:(double) i and:(double) v;
-(int) getFortyFivesNeeded;
-(int) getThirtyFivesNeeded;
-(int) getTwentyFivesNeeded;
-(int) getTensNeeded;
-(int) getFivesNeeded;
-(void) setFortyfivesNeeded:(int) needed;
-(void) setThirtyfivesNeeded:(int) needed;
-(void) setTwentyfivesNeeded:(int) needed;
-(void) setTensNeeded:(int) needed;
-(void) setFivesNeeded:(int) needed;
-(void) setTwopointfivesNeeded:(int) needed;
-(int) getTwoPointFivesNeeded;
@end
