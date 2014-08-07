//
//  NSDate+HNConvenience.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSDate+HNConvenience.h"

@implementation NSDate (HNConvenience)

#pragma mark - NSDate Methods

+ (NSDate*)dateWithISO8601CompatibleString: (NSString*)timestamp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSDate* date = [formatter dateFromString:timestamp];
    
    return date;
}



- (NSString*)timeStringForTableCell
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString* string = [formatter stringFromDate:self];
    
    return string;
}


- (NSInteger)friSatSunInteger
{
    NSInteger friSatSunInteger= -1;
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components: NSWeekdayCalendarUnit fromDate:self];
    
    NSInteger weekday = [comp weekday];
    
    if(weekday == 6) //friday
    {
        friSatSunInteger = 0;
    } else if (weekday == 7) //sat
    {
        friSatSunInteger = 1;
    }
    else if(weekday == 1) //sun
    {
        friSatSunInteger = 2;
    }
    
    return friSatSunInteger;
}





@end
