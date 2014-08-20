//
//  DatePicker.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/12/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "DatePicker.h"
#import "TrainingMaxes.h"

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
    }

-(NSString *)formatDate:(NSString *)initialDate;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date  = [dateFormatter dateFromString:initialDate];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    return newDate;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"dateToTMSegue"]){
        TrainingMaxes *controller = (TrainingMaxes *)segue.destinationViewController;
        NSString * myDate = [self formatDate:(field.text)]; //if this is right you got some splaining to do
        NSString *title = [NSString stringWithFormat:@"Starting Date: %@", myDate];
        controller.dateText =title;
    }
}


    
    
@end
