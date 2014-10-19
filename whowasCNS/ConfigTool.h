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
	NSString* CURRENT_DATE_STRING;
    
    
}

-(void) incrementCal;
-(void) setDate:(NSString*) formattedDate;
-(void)openDB:(bool)yesOrNo withContactDB:(sqlite3*) contactDB;
-(NSArray*) configureNextSetWithDate:(NSString*) myDate withLift:(NSString*)myNextLift withView:(NSString*)viewMode /*withUnitMode:(NSString*)lbMode*/ withPattern:(NSArray*) pattern withContactDB:(sqlite3*) contactDB withRounding:(BOOL) usingRounding;
-(NSArray*) getNextLift:(NSDate*) c1 withPattern:(NSArray*) myPattern andCurrentLift:(NSString*) currentLift withMode:(NSString*) viewMode;
@end
