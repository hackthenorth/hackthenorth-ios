//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNDataManager.h"
#import "SVStatusHUD.h"

const CGFloat REQUEST_TIMEOUT = 60.0f;

@implementation HNDataManager

- (instancetype)init
{
    self = [super init];
    self.displayAlert = NO;
    _alertDisplayed = NO;
    _shouldRetrieve = YES;
    _wifiStatusViewEnabled = NO;
    _saveSuccess = YES;
    _savedFiles = 0;
    _connections = [@[@"",@"",@"",@"",@""] mutableCopy];
    _requests = [@[@"",@"",@"",@"",@""] mutableCopy];
    return self;
}


- (NSArray*)keyNames
{
    return  @[@"updates", @"schedule", @"prizes", @"mentors", @"team"];
}

+ (void)loadDataForPath:(NSString *)path {
    /* Check for cached data, and notify with that if it exists.
    NSData *cachedData = nil;
    id cachedJson = [NSJSONSerialization JSONObjectWithData:cachedData options:0 error:nil];
    if (cachedJson) {
        NSDictionary *info = @{ HNDataManagerKeyData : cachedJson };
        [[NSNotificationCenter defaultCenter] postNotificationName:path object:self userInfo:info];
    }
    */
    
    // Get the new data and post that in another notification.
    NSString *urlPath = [NSString stringWithFormat:@"https://hackthenorth.firebaseio.com/mobile/%@.json", path];
    [[AFHTTPRequestOperationManager manager] GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *info = @{ HNDataManagerKeyData : responseObject };
        [[NSNotificationCenter defaultCenter] postNotificationName:path object:self userInfo:info];
        
        // Save to cache.
        //[[NSFileManager defaultManager] createFileAtPath:path contents:[responseObject data] attributes:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP request error: %@", error);
    }];
}


- (void)retrieveAppDataAndSaveToFile
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    for (NSString *keyName in self.keyNames) {
        NSString* requestString = [NSString stringWithFormat:@"https://hackthenorth.firebaseio.com/mobile/%@.json", keyName];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:REQUEST_TIMEOUT];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        connection.accessibilityLabel = keyName;
        [connection start];
    }
}


- (BOOL)saveData: (NSData*)data toFileWithName: (NSString*)filename
{
    if(!data || !filename)
    {
        NSLog(@"File Data Missing, can't save");
        return NO;
    }
    
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    NSURL* fileURL = [url URLByAppendingPathComponent:filename];
    
    return [[NSFileManager defaultManager] createFileAtPath:[fileURL path] contents:data attributes:nil];
}



- (id)retrieveArrayOrDictFromFile:(NSString*)fileName
{
    // Get the directory for this application.
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    // Add the file path to the directory URL and load.
    NSURL* fileURL = [url URLByAppendingPathComponent:fileName];
    NSData* fileData = [[NSFileManager defaultManager] contentsAtPath:[fileURL path]];

    NSLog(@"retrieving file from path %@", fileName);
    
    // If we don't have any data stored here...
    if (!fileData) {
        //[self saveFromOfflineIfNoFile];
        //fileData = [[NSFileManager defaultManager] contentsAtPath:[fileURL path]];
    }
    
    [self retrieveAppDataAndSaveToFile];
    
    return [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
}

@end
