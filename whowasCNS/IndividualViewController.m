//
//  IndividualViewController.m
//  whowasCNS
//
//  Created by Alexander Kohler on 9/25/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "IndividualViewController.h"
#import "DateAndLiftProcessor.h"
#import "ConfigTool.h"

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
    _eofText.text = _eofString;
    [self generateWeights:[_liftOne integerValue] forLift:1];
    [self generateWeights:[_liftTwo integerValue] forLift:2];
    [self generateWeights:[_liftThree integerValue] forLift:3];
    [_segueButton setUserInteractionEnabled:NO];
    //don't forget about rounding ###############################################################################################################################
}

- (IBAction)getNextLift:(id)sender {
    
        ConfigTool* configtool = [[ConfigTool alloc] init];
        NSArray* predata =[configtool getNextLift:_date withPattern:_pattern andCurrentLift:_typeFreq withMode:_viewMode];
    // result = helper.getNextLift(c1, liftPattern, liftType, viewMode);//getNextLiftDefault returns a result array which has nextLift and incrementedString
    //nextLift = result[0];
    //  incrementedString = result[1];
    
    
    
    //grab our data here....
    NSArray* data = [configtool configureNextSetWithDate:predata[1] withLift:predata[0] withView:_viewMode /*withUnitMode:_usingLbs*/ withPattern:_pattern withContactDB:_contactDB withRounding:_rounding withDirection:@"Next"]; //will have to parse out typefreq
    [configtool openDB:NO withContactDB:_contactDB];
    if (![data[6] containsString:@"End"])
    [self performSegueWithIdentifier:@"indViewNextSegue" sender:sender];
    else
        self.eofText.text = data[6];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(double) round:(double) i toNearest:(double) v //first argument is rounded,
{
    return v * floorf(i / v + 0.5f);
    //return (double) (Math.round(i/v) * v);
}




-(void) generateWeights:(double) weight forLift:(int) liftOneTwoOrThree
{
    //weight = weight(round to five)
    int barbellWeight;
    NSArray *currentPlateVal;
    if (_usingLbs)
    {
        barbellWeight = 45;
        currentPlateVal = @[@45, @25, @10, @5, @2.5];
        weight = [self round:weight toNearest:(5)];
    }
    else //using kg
    {
        barbellWeight = 20;
        currentPlateVal = @[@25, @20, @15, @10, @5, @2.5, @1.25];
        weight = [self round:weight toNearest:(2.5)];
    }
    int currentNeeded = 0;
    int plateValIterator = 0;
    int platePosition = 1;
    double plateWeight = weight - barbellWeight;
    while (plateWeight != 0)
    {
        currentNeeded = (int) (plateWeight / ([currentPlateVal[plateValIterator] doubleValue] * 2));
        if (currentNeeded > 0)
        {
            plateWeight = (double) (plateWeight - (2 * currentNeeded * [currentPlateVal[plateValIterator] doubleValue]));
            //System.out.println(currentPlateVal[plateValIterator] + " needed per side " + currentNeeded);
            int numberOfTimesToAddPlateToEachSide = currentNeeded;
            while (numberOfTimesToAddPlateToEachSide >= 1)
            {
               NSLog(@"Added %@ s to plate position %i", currentPlateVal[plateValIterator], platePosition);
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
    


        if (liftNumber == 1)
        {
            UIImageView *liftOneRightUIViews[] = {_liftOneplatePos1R, _liftOneplatePos1R, _liftOnePlatePos2R, _liftOnePlatePos3R, _liftOnePlatePos4R, _liftOnePlatePos5R, _liftOnePlatePos6R, _liftOnePlatePos7R, _liftOnePlatePos8R, _liftOneplatePos9R};
            UIImageView *liftOneLeftUIViews[] = {_liftOneplatePos1L, _liftOneplatePos1L, _liftOneplatePos2L, _liftOneplatePos3L, _liftOneplatePos4L, _liftOneplatePos5L, _liftOneplatePos6L, _liftOneplatePos7L, _liftOneplatePos8L, _liftOneplatePos9L};
        
            NSString* plateImageString = [self getPlateImageFor:plateIndex andMode:_usingLbs];
            liftOneRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftOneLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
        
        if (liftNumber == 2)
        {
            UIImageView *liftTwoRightUIViews[] = {_liftTwoPlatePos1R, _liftTwoPlatePos1R, _liftTwoPlatePos2R, _liftTwoPlatePos3R, _liftTwoPlatePos4R, _liftTwoPlatePos5R, _liftTwoPlatePos6R, _liftTwoPlatePos7R, _liftTwoPlatePos8R, _liftTwoPlatePos9R};
            UIImageView *liftTwoLeftUIViews[] = {_liftTwoPlatePos1L, _liftTwoPlatePos1L, _liftTwoPlatePos2L, _liftTwoPlatePos3L, _liftTwoPlatePos4L, _liftTwoPlatePos5L, _liftTwoPlatePos6L, _liftTwoPlatePos7L, _liftTwoPlatePos8L, _liftTwoPlatePos9L};
            
            NSString* plateImageString = [self getPlateImageFor:plateIndex andMode:_usingLbs];
            liftTwoRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftTwoLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
        
        if (liftNumber == 3)
        {
            UIImageView *liftThreeRightUIViews[] = {_liftThreeplatePos1R, _liftThreeplatePos1R, _liftThreeplatePos2R, _liftThreeplatePos3R, _liftThreeplatePos4R, _liftThreeplatePos5R, _liftThreeplatePos6R, _liftThreeplatePos7R, _liftThreeplatePos8R, _liftThreeplatePos9R};
            UIImageView *liftThreeLeftUIViews[] = {_liftThreeplatePos1L, _liftThreeplatePos1L, _liftThreeplatePos2L, _liftThreeplatePos3L, _liftThreeplatePos4L, _liftThreeplatePos5L, _liftThreeplatePos6L, _liftThreeplatePos7L, _liftThreeplatePos8L, _liftThreeplatePos9L};
            
            NSString* plateImageString = [self getPlateImageFor:plateIndex andMode:_usingLbs];
            liftThreeRightUIViews[row].image = [UIImage imageNamed:plateImageString];
            liftThreeLeftUIViews[row].image = [UIImage imageNamed:plateImageString];
        }
    
}



-(NSString*) getPlateImageFor:(int) plateIndex andMode:(BOOL) usingLbs
{
    
    if (_usingLbs)
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
            default:
                return @"Error occurred";
        }
    }

    else
    {
        //NSArray *currentPlateVal = @[@25, @20, @15, @10, @5, @2.5, @1.25];
        switch (plateIndex)
        {
            case 0:
                return @"plate_twentyfive_kg";
                break;
            case 1:
                return @"plate_twenty_kg";
                break;
            case 2:
                return @"plate_fifteen_kg";
                break;
            case 3:
                return @"plate_ten_kg";
                break;
            case 4:
                return @"plate_five_kg";
                break;
            case 5:
                return @"plate_twopointfive_kg";
                break;
            case 6:
                return @"plate_onepointtwofive_kg";
                break;
            default:
                return @"Error occurred";
                
        }
        
        
        
    }
}



//segue prep - mock hookup for 'next' segue with ID indViewNextSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"indViewNextSegue"]) {
        IndividualViewController *destViewController = segue.destinationViewController;
        
        //call our methods with our new database toys here.
        //to start, let's just try to open the database.
        ConfigTool* configtool = [[ConfigTool alloc] init];
        
        NSArray* predata =[configtool getNextLift:_date withPattern:_pattern andCurrentLift:_typeFreq withMode:_viewMode];
       // result = helper.getNextLift(c1, liftPattern, liftType, viewMode);//getNextLiftDefault returns a result array which has nextLift and incrementedString
        //nextLift = result[0];
      //  incrementedString = result[1];
        
        
     
             //grab our data here....
        NSArray* data = [configtool configureNextSetWithDate:predata[1] withLift:predata[0] withView:_viewMode /*withUnitMode:_usingLbs*/ withPattern:_pattern withContactDB:_contactDB withRounding:_rounding withDirection:@"Next"]; //will have to parse out typefreq
        [configtool openDB:NO withContactDB:_contactDB];
        //date, freq, 1,2,3 cycle
        
       
     
    
   
        destViewController.date = data[0];
        destViewController.typeFreq = [[predata[0] stringByAppendingString:@" - "] stringByAppendingString:data[1]];
        destViewController.liftOne = data[2];
        destViewController.liftTwo = data[3];
        destViewController.liftThree = data[4];
        destViewController.cycle = data[5];
        destViewController.usingLbs = _usingLbs;
        destViewController.pattern = _pattern;
        destViewController.viewMode = _viewMode;
   

    }
}








@end
