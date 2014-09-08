//
//  NSString+HNConvenience.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HNConvenience)



+ (NSString*) serializeDeviceToken:(NSData*) deviceToken;

- (NSString*)cappedString;


- (NSNumber*)convertFromPhoneStringToNumber;

@end
