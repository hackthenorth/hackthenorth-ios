//
//  NSDate+HNConvenience.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSDate+HNConvenience.h"

@implementation NSDate (HNConvenience)

#pragma mark - Convenience

+ (double)secondsWithTimeInterval: (NSTimeInterval)interval
{
    return floor(fmod(interval,60.0f));
}


+ (double)minuitesWithTimeInterval: (NSTimeInterval)interval
{
    double minutes = fmod((interval/60.0f), 60.0f);
    return floor(minutes);
}


+ (double)hoursWithTimeInterval: (NSTimeInterval)interval
{
    double hours = interval/3600.0f;
    hours = fmod(hours, 24.0f);
    return floor(hours);
}

+ (double)hoursTotalWithTimeInterval: (NSTimeInterval)interval
{
    double hours = interval/3600.0f;
    return floor(hours);
}


+ (NSString*)timeAgoStringWithTimeInterval: (NSTimeInterval)interval
{
    if(interval < 0)
        return @"in the future";
    
    NSString* returnString = @"just now";
    
    double hour = [self hoursTotalWithTimeInterval:interval];
    double min = [self minuitesWithTimeInterval:interval];
    double sec = [self secondsWithTimeInterval:interval];
    
    if(hour >= 1)
    {
        returnString = [NSString stringWithFormat:@"%.0f hours ago", hour];
    }
    else if(min >=1)
    {
        returnString = [NSString stringWithFormat:@"%.0f minutes ago", min];
    }
    else if(sec >= 30)
    {
        returnString = [NSString stringWithFormat:@"%.0f seconds ago", sec];
    }
    
    return returnString;
}



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
