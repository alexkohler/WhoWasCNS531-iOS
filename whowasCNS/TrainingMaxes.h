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
    
    IBOutlet UILabel *Screen;
    IBOutlet UITextField *benchTMField;
    IBOutlet UITextField *squatTMField;
    IBOutlet UITextField *ohpTMField;
    IBOutlet UITextField *deadTMField;
    NSInteger benchTM;
    NSInteger squatTM;
    NSInteger ohpTM;
    NSInteger deadTM;


}


-(IBAction) setDateText;
-(void)getTrainingMaxes;
@property(nonatomic) NSString *isSomethingEnabled;
@property (strong, nonatomic) IBOutlet UITextField *textField;
-(void)cancelNumberPadAt:(UITextField *) currentField;
-(void)cancelBench;
-(void)cancelSquat;
-(void)moveFrom:(UITextField *)currentField to:(UITextField *) nextField;
-(void)moveFromBench;
-(void)moveFromSquat;
@end

