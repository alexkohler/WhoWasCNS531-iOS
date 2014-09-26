//
//  IndividualViewController.m
//  whowasCNS
//
//  Created by Alexander Kohler on 9/25/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "IndividualViewController.h"

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
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
