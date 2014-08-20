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
                                [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(moveFromDead)],
                                nil];
    
    
    deadTMField.inputAccessoryView = numberToolbarDeadTM;
    
    //handle next/cancel for cycle
    
    UIToolbar* numberToolbarCycles = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarCycles.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelCycle)],
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(cancelCycle)],
                                 nil];
    
    
    cycleField.inputAccessoryView = numberToolbarCycles;
    
    
    
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
    
    numberOfCycles = [cycleField.text intValue];
    NSNumber *value = [NSNumber numberWithBool:roundSwitch.isOn];
    usingRounding= value != 0; // myBool is NO for 0, YES for anything else
    
    int intermediateValue = unitField.selectedSegmentIndex;
    usingLbs = intermediateValue == 0; // myBool is YES for 0, NO for anything else
    
}

- (IBAction)sliderChanged:(id)sender
{
    int sliderValue;
    sliderValue = lroundf(_mySlider.value);
    [_mySlider setValue:sliderValue animated:YES];
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

-(void)cancelCycle
{
    [cycleField resignFirstResponder];
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

-(void) moveFromDead
{
    //[self moveFrom:deadTMField to:cycleField];
    [cycleField becomeFirstResponder];
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"maxesToTableSegue"]){
        TableDisplay *controller = (TableDisplay *)segue.destinationViewController;
        controller.benchTM = benchTM; //the reference from where our segue is going is equal to where our segue is currently (we are transferring data)
        controller.squatTM = squatTM;
        controller.ohpTM = ohpTM;
        controller.deadTM = deadTM;
        //just creating training max stream here
        NSString *title = [NSString stringWithFormat:@"Starting TMS Bench[%zd] Squat[%zd], OHP[%zd], Dead[%zd]", benchTM, squatTM, ohpTM, deadTM];
        controller.trainingMaxStream = title;
    }
}

@end
