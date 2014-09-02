//
//  PoundPlateComputer.m
//  whowasCNS
//
//  Created by Alexander Kohler on 9/1/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "PoundPlateComputer.h"

@implementation PoundPlateComputer

-(id) init
{
    if( self = [super init] )
    {
        lb_mode = YES;//initial value
    }
    
    return self;
}

-(void) computeLbPlates:(double) myWeight withBarbellUsed:(double) barbellUsed andWithFlags:(BOOL[]) lbFlags
{
    weight = myWeight - barbellUsed;
    plateWeight = [self round:weight and:5];
  //BOOL lbHaveFortyFive = nil, lbHaveThirtyFive = nil, lbHaveTwentyFive = nil, lbHaveTen = nil, lbHaveFive = nil, lbHaveTwoPointFive= nil;
    BOOL lbHaveFortyFive = lbFlags[0];
    BOOL lbHaveThirtyFive = lbFlags[1] ;
    BOOL lbHaveTwentyFive = lbFlags[2];
    BOOL lbHaveTen = lbFlags[3];
    BOOL lbHaveFive = lbFlags[4];
    BOOL lbHaveTwoPointFive = lbFlags[5];
    
    
    double currentPlate = 0;
    for (int i=0; i<6; i++)
    {
        currentPlate_needed = 0;
        switch (i){
			case 0:
				if (!lbHaveFortyFive)
				{
					currentPlate=0;
					break;
				}
				if (lbHaveFortyFive)
				{
					currentPlate = 45;
					break;
				}
			case 1:
				if(!lbHaveThirtyFive)
				{
					currentPlate = 0;
					break;
				}
				if (lbHaveThirtyFive)
				{
					currentPlate = 35;
					break;
				}
			case 2:
				if (!lbHaveTwentyFive)
				{
					currentPlate = 0;
					break;
				}
				if (lbHaveTwentyFive)
				{
					currentPlate = 25;
					break;
				}
			case 3:
				if (!lbHaveTen)
				{
					currentPlate = 0;
					break;
				}
				if (lbHaveTen)
				{
					currentPlate = 10;
					break;
				}
			case 4:
				if (!lbHaveFive)
				{
                    currentPlate = 0;
                    break;
				}
				if (lbHaveFive)
				{
                    currentPlate = 5;
                    break;
				}
			case 5:
				if (!lbHaveTwoPointFive)
				{
                    currentPlate = 0;
                    break;
				}
				if (lbHaveTwoPointFive)
				{
                    currentPlate = 2.5;
                    break;
				}
        }//end switch
        
        if (currentPlate > 0) //weed out unneeded 35
        {
            currentPlate_needed = (int) (plateWeight / currentPlate);
            if ((currentPlate_needed % 2)!=0)//if there is an uneven number of plates
                currentPlate_needed--; //decrement and make it even
            plateWeight = plateWeight - (currentPlate_needed * currentPlate); //calculate new plateweight
            if (currentPlate_needed > 0)//weed out plates that aren't needed
            {
                currentPlateName = [NSString stringWithFormat:@"%lf", currentPlate];
                if ([currentPlateName isEqualToString:@"45.0"])
                    [self setFortyfivesNeeded:currentPlate_needed];
                else if ([currentPlateName isEqualToString:@"35.0"])
                    [self setThirtyfivesNeeded:currentPlate_needed];
                else if ([currentPlateName isEqualToString:@"25.0"])
                    [self setTwentyfivesNeeded:currentPlate_needed];
                else if ([currentPlateName isEqualToString:@"10.0"])
                    [self setTensNeeded:currentPlate_needed];
                else if ([currentPlateName isEqualToString:@"5.0"])
                    [self setFivesNeeded:currentPlate_needed];
                else if ([currentPlateName isEqualToString:@"2.5"])
                    [self setTwopointfivesNeeded:currentPlate_needed];
                
            }
        }
        
        
    }
    
    
}//end method calculate





-(double) getWeight
{
    return weight;
}

-(int) getFortyFivesNeeded
{
    return fortyfivesNeeded;
}

-(int) getThirtyFivesNeeded
{
    return thirtyfivesNeeded;
}

-(int) getTwentyFivesNeeded
{
    return twentyfivesNeeded;
}

-(int) getTensNeeded
{
    return tensNeeded;
}

-(int) getFivesNeeded
{
    return fivesNeeded;
}

-(void) setFortyfivesNeeded:(int) needed
{
    fortyfivesNeeded = needed;
}


-(void) setThirtyfivesNeeded:(int) needed
{
    thirtyfivesNeeded = needed;
}

-(void) setTwentyfivesNeeded:(int) needed
{
    twentyfivesNeeded = needed;
}

-(void) setTensNeeded:(int) needed
{
    tensNeeded = needed;
}

-(void) setFivesNeeded:(int) needed
{
    fivesNeeded = needed;
}

-(void) setTwopointfivesNeeded:(int) needed
{
    twopointfivesNeeded = needed;
}

-(int) getTwoPointFivesNeeded
{
    return twopointfivesNeeded;
}


-(double) round:(double) i and:(double) v //first argument is rounded,
{
    return v * floorf(i / v + 0.5f);
    //return (double) (Math.round(i/v) * v);
}






@end
