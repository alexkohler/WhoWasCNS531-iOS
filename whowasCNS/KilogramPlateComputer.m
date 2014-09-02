//
//  KilogramPlateComputer.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/28/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "KilogramPlateComputer.h"

@implementation KilogramPlateComputer
-(id) init
{
    if( self = [super init] )
    {
        lb_mode = YES;//initial value
    }

    return self;
}


-(void) computeKgPlates:(double) myWeight and: (double) barbellUsed withFlags:(BOOL[]) kgFlags
{
    //should unpack booleans....
    weight = myWeight - barbellUsed;
    plateWeight = [self round:weight and:2.5]; //this will have to be dynamic depending on the plates they have
    //plateWeight = weight;
    
    BOOL haveTwentyFive = kgFlags[0];
    BOOL haveTwenty = kgFlags[1];
    BOOL haveFifteen = kgFlags[2];
    BOOL haveTen = kgFlags[3];
    BOOL haveFive = kgFlags[4];
    BOOL haveTwoPointFive = kgFlags[5];
    BOOL haveOnePointTwoFive = kgFlags[6];
    
    double currentPlate = 0;
    //boolean thirtyfive_flag = true;
    for (int i=0; i<7; i++)
    {
        currentPlate_needed = 0;
        switch (i){
			case 0:
				if(!haveTwentyFive) //could add a flag for each of these to allow user to specify what plates they have
				{
					currentPlate = 0;
					break;
				}
				if (haveTwentyFive)
				{
					currentPlate = 25;
					break;
				}
			case 1:
				if(!haveTwenty) //could add a flag for each of these to allow user to specify what plates they have
				{
					currentPlate = 0;
					break;
				}
				if (haveTwenty)
				{
					currentPlate = 20;
					break;
				}
			case 2:
				if (!haveFifteen)
				{
					currentPlate = 0;
					break;
				}
				if (haveFifteen)
				{
					currentPlate = 15;
					break;
				}
			case 3:
				if (!haveTen)
				{
					currentPlate = 0;
					break;
				}
				if (haveTen)
				{
					currentPlate = 10;
					break;
				}
			case 4:
				if (!haveFive)
				{
					currentPlate = 0;
					break;
				}
				if (haveFive)
				{
                    currentPlate = 5;
                    break;
				}
			case 5:
				if (!haveTwoPointFive)
				{
					currentPlate = 0;
					break;
				}
				if (haveTwoPointFive)
				{
					currentPlate = 2.5;
					break;
				}
			case 6:
				if (!haveOnePointTwoFive)
				{
					currentPlate = 0;
					break;
				}
				if (haveOnePointTwoFive)
				{
					currentPlate = 1.25;
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
//                currentPlateName = String.valueOf(currentPlate).intern();
                currentPlateName = [NSString stringWithFormat:@"%lf", currentPlate];
                //no string switch is really killing me objective c....

                        if ([currentPlateName isEqualToString:@"25.0"])
                            [self setTwentyFivesNeeded:currentPlate_needed];
					else if ([currentPlateName isEqualToString:@"20.0"])
						[self setTwentysNeeded:currentPlate_needed];
                    else if ([currentPlateName isEqualToString:@"15.0"])
						[self setFifteensNeeded:currentPlate_needed];
					else if ([currentPlateName isEqualToString:@"10.0"])
						[self setTensNeeded:currentPlate_needed];
					else if ([currentPlateName isEqualToString:@"5.0"])
                        [self setFivesNeeded:currentPlate_needed]; //what's needed per side
                    else if ([currentPlateName isEqualToString:@"2.5"])
                        [self setTwopointfivesNeeded:currentPlate_needed]; //what's needed per side
					else if ([currentPlateName isEqualToString:@"1.25"])
                        [self setOnepointtwofivesNeeded:currentPlate_needed];

            }
        }
    }
}//end method calculate

-(double) getWeight
{
    return weight;
}

//One way is to multiply your number by a number that will allow rounding by Math.round(...) to do the correct rounding, and then
//divide by that number before using String.format(...) or
//DecimalFormat to produce a nice String representation.
//You could multiply the number by 0.4 or divide it by 2.5,
//then round it to the nearest int, then divide the result by 0.4 or multiply it by 2.5 to get the result,
//but then use a String formatting tool to round this to 1 decimal place. String.format("%.1f", myNumber) could work well for this.
-(double) round:(double) i and:(double) v //first argument is rounded,
{
    return v * floorf(i / v + 0.5f);
    //return (double) (Math.round(i/v) * v);
}


-(int) getTwentyFivesNeeded
{
    return twentyFivesNeeded;
}


-(void) setTwentyFivesNeeded:(int) twentyfivesneeded
{
    twentyFivesNeeded = twentyfivesneeded;
}

-(int) getTwentysNeeded
{
    return twentysNeeded;
}


-(void) setTwentysNeeded:(int) twentysneeded
{
    twentysNeeded = twentysneeded;
}

-(int) getFifteensNeeded
{
    return fifteensNeeded;
}

-(void) setFifteensNeeded:(int) fifteensneeded
{
    fifteensNeeded = fifteensneeded;
}

-(int) getTensNeeded
{
    return tensNeeded;
}

-(void) setTensNeeded:(int) tensneeded
{
    tensNeeded = tensneeded;
}

-(int) getFivesNeeded
{
    return fivesNeeded;
}

-(void) setFivesNeeded:(int) fivesneeded
{
    fivesNeeded = fivesneeded;
}

-(int) getTwopointfivesNeeded
{
    return twopointfivesNeeded;
}

-(void) setTwopointfivesNeeded:(int) twopointfivesneeded
{
    twopointfivesNeeded = twopointfivesneeded;
}

-(int) getOnepointtwofivesNeeded
{
    return onepointtwofivesNeeded;
}

-(void) setOnepointtwofivesNeeded:(int) onepointtwofivesneeded
{
    onepointtwofivesNeeded = onepointtwofivesneeded;
}
@end
