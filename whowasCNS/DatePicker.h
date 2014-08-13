//
//  DatePicker.h
//  whowasCNS
//
//  Created by Alexander Kohler on 8/12/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePicker : UIViewController
{
	IBOutlet UIDatePicker *picker;
	IBOutlet UITextField  *field;
}

-(IBAction)displayDate:(id)sender;

@end
