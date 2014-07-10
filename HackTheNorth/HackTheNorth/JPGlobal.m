//
//  JPGlobal.m
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-05-14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPGlobal.h"


@implementation JPGlobal




+ (NSString*)monthStringWithInt: (int)month
{
    
    switch (month)
    {
        case 1:
            return @"January";
        case 2:
            return @"February";
        case 3:
            return @"March";
        case 4:
            return @"April";
        case 5:
            return @"May";
        case 6:
            return @"June";
        case 7:
            return @"July";
        case 8:
            return @"August";
        case 9:
            return @"September";
        case 10:
            return @"October";
        case 11:
            return @"November";
        case 12:
            return @"December";
        default:
            return @"-----";

    }

}


+ (NSString*)ratingStringWithIndex: (NSInteger)index
{
    
    switch (index)
    {
        case 0:
            return @"Difficulty";
        case 1:
            return @"Professors";
        case 2:
            return @"Schedule";
        case 3:
            return @"Classmates";
        case 4:
            return @"Social";
        case 5:
            return @"Study Environment";
        default:
            return @"";
            
    }
    
}



+ (NSString*)schoolYearStringWithInteger: (NSUInteger)year
{
    NSArray* schoolYearsInString = @[@"First Year",@"Second Year",@"Third Year",@"Fourth Year"];
    return schoolYearsInString[year-1];
}





@end
