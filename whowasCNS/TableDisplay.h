//
//  TableDisplay.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDisplay : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *trainingMaxStreamLabel;
    
}

@property(nonatomic) NSString  *trainingMaxStream;
@property(nonatomic) NSInteger benchTM;
@property(nonatomic) NSInteger squatTM;
@property(nonatomic) NSInteger ohpTM;
@property(nonatomic) NSInteger deadTM;

@end