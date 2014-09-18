//
//  MyViewController.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/21/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdjustPattern : UITableViewController
@property (nonatomic, strong) NSMutableArray *tableData;
@property (weak, nonatomic) IBOutlet UILabel *errorStream;
@property(nonatomic) NSDate *chosenDate;
@property (nonatomic) NSArray *patternArray;


@end
