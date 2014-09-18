//
//  HNDataManager.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// The NSString key for JSON response data in the userInfo of the notification posted by the method
// loadDataForPath:NSString.
static NSString* const HNDataManagerKeyData = @"data";

@interface HNDataManager : UIViewController

+ (void)loadDataForPath:(NSString *)path;

@end


