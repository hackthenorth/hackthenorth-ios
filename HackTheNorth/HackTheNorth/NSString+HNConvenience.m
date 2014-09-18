//
//  NSString+HNConvenience.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "NSString+HNConvenience.h"

@implementation NSString (HNConvenience)


+ (NSString*) serializeDeviceToken:(NSData*) deviceToken
{
    NSMutableString *str = [NSMutableString stringWithCapacity:64];
    int length = [deviceToken length];
    char *bytes = malloc(sizeof(char) * length);
    
    [deviceToken getBytes:bytes length:length];
    
    for (int i = 0; i < length; i++)
    {
        [str appendFormat:@"%02.2hhX", bytes[i]];
    }
    free(bytes);
    
    return str;
}


- (NSString*)cappedString
{
    NSString* capItemName = self;
    if(self && ![self isEqual:@""])
    {
        NSString* cap = [[self substringToIndex:1] uppercaseString];
        NSString* half = [self substringFromIndex:1];
        capItemName = [cap stringByAppendingString:half];
    }
    
    return capItemName;
}

//+1 (416) 123-4567 format
//or 4161234567 regular format

- (NSNumber*)convertFromPhoneStringToNumber
{
    if([self rangeOfString:@"("].location==NSNotFound && [self rangeOfString:@")"].location==NSNotFound)
    {
        NSNumber* phoneNum = [NSNumber numberWithLongLong:[self longLongValue]];
        return phoneNum;
    }
        
    NSString* inter = [self substringWithRange:NSMakeRange(1, 1)];
    NSString* area = [self substringWithRange:NSMakeRange(4, 3)];
    
    NSString* num1 = [self substringWithRange:NSMakeRange(9, 3)];
    NSString* num2 = [self substringWithRange:NSMakeRange(13, 4)];
    
    NSString* phoneString = [NSString stringWithFormat:@"%@%@%@%@", inter, area, num1, num2];

    NSNumber* phoneNumber = [NSNumber numberWithLongLong:[phoneString longLongValue]];
    return phoneNumber;
}






@end
