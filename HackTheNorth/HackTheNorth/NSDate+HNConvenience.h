//
//  NSDate+HNConvenience.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HNConvenience)

+ (NSDate*)dateWithISO8601CompatibleString: (NSString*)timestamp;

- (NSString*)timeStringForTableCell;

- (NSInteger)friSatSunInteger;


@end
