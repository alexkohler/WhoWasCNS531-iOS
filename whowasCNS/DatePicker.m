//
//  DatePicker.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/12/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "DatePicker.h"

@implementation DatePicker
-(IBAction)displayDate:(id)sender {
	NSDate * selected = [picker date];
	NSString * date = [selected description];
	field.text = date;
}

- (void)viewDidLoad {
	NSDate *now = [NSDate date];
	[picker setDate:now animated:YES];
	field.text = [now description];
}@end
