//
//  NSDate+HNConvenience.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HNConvenience)


+ (double)secondsWithTimeInterval: (NSTimeInterval)interval; //0-59 only
+ (double)minuitesWithTimeInterval: (NSTimeInterval)interval; //0-59 only
+ (double)hoursWithTimeInterval: (NSTimeInterval)interval; //0-23 only
+ (double)hoursTotalWithTimeInterval: (NSTimeInterval)interval; //0-9999..
+ (NSString*)timeAgoStringWithTimeInterval: (NSTimeInterval)interval;

+ (NSDate*)dateWithISO8601CompatibleString: (NSString*)timestamp;

- (NSString*)timeStringForTableCell;
- (NSString*)dateStringForTableCell;

- (NSInteger)friSatSunInteger;


@end
