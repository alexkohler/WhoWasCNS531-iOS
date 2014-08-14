//
//  TrainingMaxes.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/13/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "TrainingMaxes.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) setDateText
{
    Screen.text = [NSString stringWithFormat:@"%@",_isSomethingEnabled];
}

-(IBAction)getTrainingMaxes
{
    benchTM = [benchTMField.text intValue];
    squatTM = [squatTMField.text intValue];
    ohpTM = [ohpTMField.text intValue];
    deadTM = [deadTMField.text intValue];
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
