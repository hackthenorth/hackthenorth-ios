//
//  HNDataManager.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static NSString* const kNeedUpdateDataNotification = @"kNeedUpdateDataNotification";


@interface HNDataManager : NSObject
{
    BOOL   _alertDisplayed;
    AFNetworkReachabilityManager* reachability;
    
    NSTimer * _timer;
    NSTimer * _minTimer;
    
    BOOL   _shouldRetrieve;
}


@property (atomic, assign) BOOL displayAlert;

- (NSArray*)keyNames;

- (void)startUpdating;
- (void)stopUpdating;

- (void)retrieveAppDataAndSaveToFile;

- (void)saveData: (NSData*)data toFileWithName: (NSString*)filename;

- (NSArray*)retrieveArrayFromFile: (NSString*)fileName;

- (NSDate*)dateWithISO8601CompatibleString: (NSString*)timestamp;

- (NSString*)timeStringFromDate: (NSDate*)date;


@end


