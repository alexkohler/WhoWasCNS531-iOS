//
//  IndividualViewController.m
//  whowasCNS
//
//  Created by Alexander Kohler on 9/25/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "IndividualViewController.h"
#import "DateAndLiftProcessor.h"

@interface IndividualViewController ()

@end

@implementation IndividualViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dateLabel.text = _date;
    _typeFreqLabel.text = _typeFreq;
    _liftOneLabel.text = _liftOne;
    _liftTwoLabel.text = _liftTwo;
    _liftThreeLabel.text = _liftThree;
    _cycleLabel.text = _cycle;
    [self generateWeights:[_liftOne integerValue] forLift:1];
    [self generateWeights:[_liftTwo integerValue] forLift:2];
    [self generateWeights:[_liftThree integerValue] forLift:3];
    //don't forget about rounding
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) generateWeights:(int) weight forLift:(int) liftOneTwoOrThree
{
    //weight = weight(round to five)
    int barbellWeight = 45;
    int plateWeight = weight - barbellWeight;
    NSArray *currentPlateVal = @[@45, @25, @10, @5, @2.5];
    int currentNeeded = 0;
    int plateValIterator = 0;
    int platePosition = 1;
    while (plateWeight != 0)
    {
        currentNeeded = (int) (plateWeight / ([currentPlateVal[plateValIterator] doubleValue] * 2));
        if (currentNeeded > 0)
        {
            plateWeight = (int) (plateWeight - (2 * currentNeeded * [currentPlateVal[plateValIterator] doubleValue]));
            //System.out.println(currentPlateVal[plateValIterator] + " needed per side " + currentNeeded);
            int numberOfTimesToAddPlateToEachSide = currentNeeded;
            while (numberOfTimesToAddPlateToEachSide >= 1)
            {
              //  System.out.println("Added " + currentPlateVal[plateValIterator] + "s to plate position " + platePosition);
                [self setPlateImageAtRow:platePosition withPlateIndex:plateValIterator forLift:liftOneTwoOrThree];
                platePosition++;
                numberOfTimesToAddPlateToEachSide--;
            }
        }
        plateValIterator++;
        
    }
}


-(void) setPlateImageAtRow:(int) row withPlateIndex:(int) plateIndex forLift:(int) liftNumber
{
    
    if (_usingLbs)
    {

        if (liftNumber == 1)
        {
            UIImageView *liftOneRightUIViews[] = {_liftOneplatePos1R, _liftOneplatePos1R, _liftOnePlatePos2R, _liftOnePlatePos3R, _liftOnePlatePos4R, _liftOnePlatePos5R, _liftOnePlatePos6R, _liftOnePlatePos7R, _liftOnePlatePos8R, _liftOneplatePos9R};
            UIImageView *liftOneLeftUIViews[] = {_liftOneplatePos1L, _liftOneplatePos1L, _liftOneplatePos2L, _liftOneplatePos3L, _liftOneplatePos4L, _liftOneplatePos5L, _liftOneplatePos6L, _liftOneplatePos7L, _liftOneplatePos8L, _liftOneplatePos9L};
        
            NSString* plateImageString = [self getPoundPlateImageFor:plateIndex];
            liftOneRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftOneLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
        
        if (liftNumber == 2)
        {
            UIImageView *liftTwoRightUIViews[] = {_liftTwoPlatePos1R, _liftTwoPlatePos1R, _liftTwoPlatePos2R, _liftTwoPlatePos3R, _liftTwoPlatePos4R, _liftTwoPlatePos5R, _liftTwoPlatePos6R, _liftTwoPlatePos7R, _liftTwoPlatePos8R, _liftTwoPlatePos9R};
            UIImageView *liftTwoLeftUIViews[] = {_liftTwoPlatePos1L, _liftTwoPlatePos1L, _liftTwoPlatePos2L, _liftTwoPlatePos3L, _liftTwoPlatePos4L, _liftTwoPlatePos5L, _liftTwoPlatePos6L, _liftTwoPlatePos7L, _liftTwoPlatePos8L, _liftTwoPlatePos9L};
            
            NSString* plateImageString = [self getPoundPlateImageFor:plateIndex];
            liftTwoRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftTwoLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
        
        if (liftNumber == 3)
        {
            UIImageView *liftThreeRightUIViews[] = {_liftThreeplatePos1R, _liftThreeplatePos1R, _liftThreeplatePos2R, _liftThreeplatePos3R, _liftThreeplatePos4R, _liftThreeplatePos5R, _liftThreeplatePos6R, _liftThreeplatePos7R, _liftThreeplatePos8R, _liftThreeplatePos9R};
            UIImageView *liftThreeLeftUIViews[] = {_liftThreeplatePos1L, _liftThreeplatePos1L, _liftThreeplatePos2L, _liftThreeplatePos3L, _liftThreeplatePos4L, _liftThreeplatePos5L, _liftThreeplatePos6L, _liftThreeplatePos7L, _liftThreeplatePos8L, _liftThreeplatePos9L};
            
            NSString* plateImageString = [self getPoundPlateImageFor:plateIndex];
            liftThreeRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftThreeLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
        
        
    }

}

-(NSString*) getPoundPlateImageFor:(int) plateIndex
{
    
   //for reference -  NSArray *currentPlateVal = @[@45, @25, @10, @5, @2.5];
    switch (plateIndex)
    {
        case 0:
            return @"plate_fourtyfive_lbs.png";
            break;
        case 1:
            return @"plate_twentyfive_lbs.png";
            break;
        case 2:
            return @"plate_ten_lbs.png";
            break;
        case 3:
            return @"plate_five_lbs.png";
            break;
        case 4:
            return @"plate_twopointfive_lbs.png";
            break;
            
    }

    return @"shit";
}



@end
