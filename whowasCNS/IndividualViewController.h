//
//  IndividualViewController.h
//  whowasCNS
//
//  Created by Alexander Kohler on 9/25/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface IndividualViewController : UIViewController
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeFreqLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftThreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *cycleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eofText;
@property (strong, nonatomic)  NSString *date;
@property (strong, nonatomic)  NSString *typeFreq;
@property (strong, nonatomic)  NSString *liftOne;
@property (strong, nonatomic)  NSString *liftTwo;
@property (strong, nonatomic)  NSString *liftThree;
@property (strong, nonatomic)  NSString *cycle;
@property (strong, nonatomic) NSString *eofString;
@property (nonatomic)  BOOL usingLbs;
@property (strong, nonatomic) IBOutlet UIButton *nextSegueButton;
@property (strong, nonatomic) IBOutlet UIButton *prevSegueButton;

-(IBAction)nextButtonClicked:(id)sender;

// for sake of accessing db
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) IBOutlet UILabel *status;

//additional params needed for ConfigTool
@property (strong, nonatomic) NSArray *pattern;
@property (nonatomic) BOOL rounding;
@property (nonatomic) NSString* viewMode;

//Barbell - lift one
@property (strong, nonatomic) IBOutlet UIImageView *liftOneBarbell;

//Plate limit - lift one
@property (strong, nonatomic) IBOutlet UILabel *liftOnePlateLimit;

//Plate positions - Lift one
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos1R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos2R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos3R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos4R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos5R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos6R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos7R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOnePlatePos8R;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos9R;

@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos1L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos2L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos3L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos4L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos5L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos6L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos7L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos8L;
@property (strong, nonatomic) IBOutlet UIImageView *liftOneplatePos9L;

//Barbell - lift two
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoBarbell;

//Plate limit - lift two
@property (strong, nonatomic) IBOutlet UILabel *liftTwoPlateLimit;

//Plate positions - lift two
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos1R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos2R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos3R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos4R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos5R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos6R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos7R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos8R;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos9R;

@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos1L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos2L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos3L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos4L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos5L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos6L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos7L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos8L;
@property (strong, nonatomic) IBOutlet UIImageView *liftTwoPlatePos9L;

//Barbell - lift three
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeBarbell;


//Plate limit - lift three
@property (strong, nonatomic) IBOutlet UIImageView *liftThreePlateLimit;


//Plate positions - lift three
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos1R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos2R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos3R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos4R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos5R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos6R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos7R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos8R;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos9R;


@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos1L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos2L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos3L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos4L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos5L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos6L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos7L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos8L;
@property (strong, nonatomic) IBOutlet UIImageView *liftThreeplatePos9L;




//Methods
-(void) generateWeights:(int) weight;

- (void)didReceiveMemoryWarning;

@end
