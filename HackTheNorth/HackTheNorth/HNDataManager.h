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

@interface HNDataManager : NSObject <NSURLConnectionDataDelegate>
{
    BOOL   _alertDisplayed;
    AFNetworkReachabilityManager* reachability;
    
    NSMutableArray* _requests;
    NSMutableArray* _connections;
    NSURLConnection*     _connection;
    NSMutableURLRequest* _request;
    
    NSTimer*   _statusTimer;
    NSTimer*   _stopStatusTimer;
    
    NSTimer * _timer;
    NSTimer * _minTimer;
    
    BOOL   _shouldRetrieve;
    
    BOOL   _wifiStatusViewEnabled;
    
    BOOL   _saveSuccess;
    NSInteger _savedFiles;
    
    NSTimer* _saveTimer;
}


@property (atomic, assign) BOOL displayAlert;

//Networking and Files
- (NSArray*)keyNames;

- (void)retrieveAppDataAndSaveToFile;
- (BOOL)saveData: (NSData*)data toFileWithName: (NSString*)filename;
- (id)retrieveArrayOrDictFromFile: (NSString*)fileName;

+ (void)loadDataForPath:(NSString *)path;

@end


