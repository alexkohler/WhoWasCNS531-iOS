//
//  IndividualViewController.h
//  whowasCNS
//
//  Created by Alexander Kohler on 9/25/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndividualViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeFreqLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *liftThreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *cycleLabel;
@property (strong, nonatomic)  NSString *date;
@property (strong, nonatomic)  NSString *typeFreq;
@property (strong, nonatomic)  NSString *liftOne;
@property (strong, nonatomic)  NSString *liftTwo;
@property (strong, nonatomic)  NSString *liftThree;
@property (strong, nonatomic)  NSString *cycle;
@end
