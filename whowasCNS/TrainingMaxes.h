//
//  TrainingMaxes.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/13/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingMaxes : UIViewController <UITextFieldDelegate>
{
    
    IBOutlet UILabel *Screen; //rename me
    IBOutlet UITextField *benchTMField;
    IBOutlet UITextField *squatTMField;
    IBOutlet UITextField *ohpTMField;
    IBOutlet UITextField *deadTMField;
    IBOutlet UITextField *cycleField;
    IBOutlet UISwitch *roundSwitch;
    IBOutlet UISegmentedControl *unitField;
    
    NSInteger benchTM;
    NSInteger squatTM;
    NSInteger ohpTM;
    NSInteger deadTM;
    NSInteger numberOfCycles;
    BOOL usingLbs;
    BOOL usingRounding;
    
}

@property(nonatomic) NSString *dateText;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
- (IBAction)sliderChanged:(id)sender;
-(IBAction) setDateText;
-(void)getInput;
-(void)cancelBench;
-(void)cancelSquat;
-(void)moveFrom:(UITextField *)currentField to:(UITextField *) nextField;
-(void)moveFromBench;
-(void)moveFromSquat;
-(void)cancelCycle;
@end

