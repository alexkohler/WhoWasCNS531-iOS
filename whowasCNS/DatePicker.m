//
//  DatePicker.m
//  whowasCNS
//
//  Created by Alexander Kohler on 8/12/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "DatePicker.h"
#import "TrainingMaxes.h"
#import "AdjustPattern.h"

@implementation DatePicker
-(IBAction)displayDate:(id)sender {
    pickerDate = [picker date];
	}

- (void)viewDidLoad {
	NSDate *now = [NSDate date];
	[picker setDate:now animated:YES];
	
    
    //if user is coming from pattern segue
   if (_storedDate != nil )
       [picker setDate:_storedDate];
   
    //if user didn not specify a custom pattern 
    if (_patternArray == nil)
        _patternArray = @[@"Bench",@"Squat",@"Rest",@"OHP",@"Deadlift", @"Rest"];
    else
    currentPatternField.text = [[_patternArray valueForKey:@"description"] componentsJoinedByString:@" - "];
    
}

-(NSString *)formatDate:(NSString *)initialDate;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    pickerDate  = [dateFormatter dateFromString:initialDate];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:pickerDate];
    return newDate;
}

-(NSString *)formatDateDate:(NSDate *)initialDate;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSString* result = [dateFormatter stringFromDate:initialDate];
    return result;
   }



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"dateToTMSegue"]){
        TrainingMaxes *controller = (TrainingMaxes *)segue.destinationViewController;
//        pickerDateString = [picker description];
        //NSString *title = [NSString stringWithFormat:@"Starting Date: %@", pickerDateString];
        controller.dateText = [self formatDateDate:[picker date]];
        controller.patternArray = _patternArray; //Simply passing patternArray down the line 
    }
    
    if([segue.identifier isEqualToString:@"dateToPatternSegue"]){
        //pass date back here - declare properties here and at pattern.m, implement a prepareForSegue method over at :: as well.
        AdjustPattern *patternController = (AdjustPattern *)segue.destinationViewController;
        patternController.chosenDate = [picker date];
    }
}


    
    
@end
