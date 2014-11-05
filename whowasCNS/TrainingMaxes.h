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
    IBOutlet UISegmentedControl *cycleField;
    IBOutlet UISwitch *roundSwitch;
    IBOutlet UISegmentedControl *unitField;
    IBOutlet UITextView *errorStreamField;
    IBOutlet UIScrollView *scrollView;
    
    
    NSInteger benchTM;
    NSInteger squatTM;
    NSInteger ohpTM;
    NSInteger deadTM;
    NSInteger numberOfCycles;
    BOOL usingLbs;
    BOOL usingRounding;

    
}
@property(nonatomic) NSString *benchTMFieldText;
@property(nonatomic) NSString *squatTMFieldText;
@property(nonatomic) NSString *ohpTMFieldText;
@property(nonatomic) NSString *deadTMFieldText;
@property(nonatomic) BOOL roundingFieldStatus;
@property(nonatomic) BOOL usingLbsFieldStatus;
@property(nonatomic) int numberOfCycles;


@property(nonatomic) NSString *dateText;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic) NSArray *patternArray;
-(BOOL) checkForProperInput;
-(IBAction) setDateText;
-(void)getInput;
-(void)cancelBench;
-(void)cancelSquat;
-(void)moveFrom:(UITextField *)currentField to:(UITextField *) nextField;
-(void)moveFromBench;
-(void)moveFromSquat;
@end

