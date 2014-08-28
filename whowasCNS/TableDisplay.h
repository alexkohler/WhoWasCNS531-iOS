//
//  TableDisplay.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/19/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TableDisplay : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *trainingMaxStreamLabel;
    
}
//data retrieved from text fields
@property(nonatomic) NSString  *trainingMaxStream;
@property(nonatomic) NSInteger benchTM;
@property(nonatomic) NSInteger squatTM;
@property(nonatomic) NSInteger ohpTM;
@property(nonatomic) NSInteger deadTM;
@property(nonatomic) BOOL usingLbs;
@property(nonatomic) BOOL usingRounding;
@property(nonatomic) NSArray *patternArray;

//database properties
- (IBAction)addEvent;
- (IBAction)getData;
@property(nonatomic) NSString *dateText;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) IBOutlet UILabel *status;//db status
@end