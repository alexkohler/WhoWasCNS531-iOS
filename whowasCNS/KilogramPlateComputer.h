//
//  KilogramPlateComputer.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/28/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KilogramPlateComputer : NSObject
{
    bool lb_mode;
    
	//weight entered
	double weight;
    
	//weight not including bar
	double plateWeight;
    
    
	//weight remaining (for sanity checks and more readable calculation
    
	int twentyFivesNeeded;
	int twentysNeeded;
	int fifteensNeeded;
	int tensNeeded;
	int fivesNeeded;
	int twopointfivesNeeded;
	int onepointtwofivesNeeded;
	int currentPlate_needed;
	NSString* currentPlateName;
}

-(void) computeKgPlates:(double) myWeight and: (double) barbellUsed withFlags:(BOOL[]) kgFlags;
-(double) round:(double) i and:(double) v;

@end
