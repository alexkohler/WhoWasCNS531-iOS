//
//  TrainingMaxes.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/13/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TrainingMaxes.h"
#import "TableDisplay.h"

@interface TrainingMaxes ()

@end

@implementation TrainingMaxes


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
    [self setDateText];
    //handle next and cancel buttons for bench
    
    UIToolbar* numberToolbarBenchTM = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarBenchTM.items = [NSArray arrayWithObjects:
                                  [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBench)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(moveFromBench)],
                           nil];
    
    
    benchTMField.inputAccessoryView = numberToolbarBenchTM;
    
    
    
    //handle next/cancel for squat
    UIToolbar* numberToolbarSquatTM = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarSquatTM.items = [NSArray arrayWithObjects:
                                  [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelSquat)],
                                  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(moveFromSquat)],
                                  nil];
    
    
    squatTMField.inputAccessoryView = numberToolbarSquatTM;
    
    //handle next/cancel for OHP
    UIToolbar* numberToolbarOhpTM = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarOhpTM.items = [NSArray arrayWithObjects:
                                  [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelOHP)],
                                  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(moveFromOHP)],
                                  nil];
    
    
    ohpTMField.inputAccessoryView = numberToolbarOhpTM;
    
    
    //handle next/cancel for Dead
    UIToolbar* numberToolbarDeadTM = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarDeadTM.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDead)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDead)],
                                nil];
    
    
    deadTMField.inputAccessoryView = numberToolbarDeadTM;
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) setDateText
{
    Screen.text = [NSString stringWithFormat:@"%@",_dateText];
}

-(IBAction)getInput
{
    benchTM = [benchTMField.text intValue];
    squatTM = [squatTMField.text intValue];
    ohpTM = [ohpTMField.text intValue];
    deadTM = [deadTMField.text intValue];
    
    numberOfCycles = unitField.selectedSegmentIndex + 1; //0 indexed
    
    NSNumber *value = [NSNumber numberWithBool:roundSwitch.isOn];
    usingRounding= value != 0; // myBool is NO for 0, YES for anything else
    
    int intermediateValue = unitField.selectedSegmentIndex;
    usingLbs = intermediateValue == 0; // myBool is YES for 0, NO for anything else
    
}

//checkForFieldError - returns true if there is an error within one of the fields and also generates an errorStream to errorStreamFIeld
-(BOOL) checkForProperInput
{
    NSString *errorStream = @"";
    
    
    NSString* emptyLiftString = @"One or more of your training max fields is empty!";
    NSString* zeroLiftString = @"Please enter a training max greater than 0!";
    NSString* reasonableLiftString = @"Please enter reasonable numbers for your lifts";

    
    BOOL errorFree = YES; //will pass until failure  (duh)
    
    if (benchTMField.text.length == 0 || squatTMField.text.length == 0 || deadTMField.text.length == 0 || ohpTMField.text.length == 0)
    {
        errorStream = [ errorStream stringByAppendingString:@"\n"];
        errorStream = [ errorStream stringByAppendingString:emptyLiftString];
        errorFree = NO; //can assign this error flag to any of the lifts, one failure will cause validation to fail
    }
    
    else if (benchTMField.text == 0 || squatTMField.text == 0 || deadTMField.text == 0 || ohpTMField.text == 0)
    {
        errorStream = [ errorStream stringByAppendingString:@"\n"];
        errorStream = [ errorStream stringByAppendingString:zeroLiftString];
        errorFree = NO; //can assign this error flag to any of the lifts, one failure will cause validation to fail
    }
    
    else
    {
        if (benchTM >= 1100 || squatTM >= 1100 || deadTM >= 1100 || ohpTM >= 1100)
        {
            errorStream = [ errorStream stringByAppendingString:@"\n"];
            errorStream = [ errorStream stringByAppendingString:reasonableLiftString];
            errorFree = NO; //can assign this error flag to any of the lifts, one failure will cause validation to fail
        }
    }
    
    

    
    

    [errorStreamField setText:errorStream];
    return errorFree;
}



//since selector methods can't have arguments create a wrappers for each lift type
-(void)cancelBench
{
    [benchTMField resignFirstResponder];
}

-(void)cancelSquat
{
    [squatTMField resignFirstResponder];
}

-(void)cancelOHP
{
    [ohpTMField resignFirstResponder];
}

-(void)cancelDead
{
    [deadTMField resignFirstResponder];
}


-(void)moveFrom:(UITextField *)currentField to:(UITextField *) nextField{
    //NSString *numberFromTheKeyboard = currentField.text;
    [nextField becomeFirstResponder];
}

//since selector methods can't have arguments create a wrappers for each lift type
-(void)moveFromBench
{
    [self moveFrom:benchTMField to:squatTMField];
}

-(void) moveFromSquat
{
    [self moveFrom:squatTMField to:ohpTMField];
}

-(void) moveFromOHP
{
    [self moveFrom:ohpTMField to:deadTMField];
}




- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL fieldErrors = [self checkForProperInput];
    return fieldErrors;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"maxesToTableSegue"]){
        TableDisplay *controller = (TableDisplay *)segue.destinationViewController;
        controller.benchTM = benchTM; //the reference from where our segue is going is equal to where our segue is currently (we are transferring data)
        controller.squatTM = squatTM;
        controller.ohpTM = ohpTM;
        controller.deadTM = deadTM;
        controller.usingRounding = usingRounding;
        controller.usingLbs = usingLbs;
        //just creating training max stream here
        NSString *unitString;
        usingLbs ? unitString = @"Mode: Lbs" : @"Mode: Kgs";
        
        NSString *modeString;
        usingRounding ? modeString = @"YES" : @"NO";
        
        
        
        NSString *title = [NSString stringWithFormat:@"Starting TMS Bench[%zd] Squat[%zd], OHP[%zd], Dead[%zd] Rounding? [%@] %@", benchTM, squatTM, ohpTM, deadTM, modeString, unitString];
        controller.trainingMaxStream = title;
    }
    
    
}

@end
