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



@end
