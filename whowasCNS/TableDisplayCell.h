//
//  TableDisplayCell.h
//  whowasCNS
//
//  Created by Alexander Kohler on 9/11/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDisplayCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *typeFreq;
@property (strong, nonatomic) IBOutlet UILabel *liftOne;
@property (strong, nonatomic) IBOutlet UILabel *liftTwo;
@property (strong, nonatomic) IBOutlet UILabel *liftThree;
@property (strong, nonatomic) IBOutlet UILabel *cycle;

@end
