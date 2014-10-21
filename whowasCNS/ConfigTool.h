//
//  ConfigTool.h
//  whowasCNS
//
//  Created by Alexander Kohler on 10/17/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#ifndef whowasCNS_ConfigTool_h
#define whowasCNS_ConfigTool_h


#endif

@interface ConfigTool : NSObject 
{
	NSString* INCREMENTED_DATE_STRING;
    
    
}

-(NSString*) incrementCal:(NSString*)CURRENT_DATE_CAL withDays:(int) days;
-(void) setDate:(NSString*) formattedDate;
-(void)openDB:(bool)yesOrNo withContactDB:(sqlite3*) contactDB;
-(NSArray*) configureNextSetWithDate:(NSString*) myDate withLift:(NSString*)myNextLift withView:(NSString*)viewMode /*withUnitMode:(NSString*)lbMode*/ withPattern:(NSArray*) pattern withContactDB:(sqlite3*) contactDB withRounding:(BOOL) usingRounding withDirection:(NSString*) nextOrBack;
-(NSArray*) getNextLift:(NSString*) c1 withPattern:(NSArray*) myPattern andCurrentLift:(NSString*) currentLift withMode:(NSString*) viewMode;
@end
