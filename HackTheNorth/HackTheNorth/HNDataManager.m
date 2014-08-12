//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNDataManager.h"




#define minUpdateTime  20.0f

@implementation HNDataManager

- (instancetype)init
{
    self = [super init];
    self.displayAlert = NO;
    _alertDisplayed = NO;
    _shouldRetrieve = YES;
    
    return self;
}


- (NSArray*)keyNames
{
    return  @[@"updates", @"schedule", @"prizes", @"mentors", @"team"];
}


- (void)startUpdating
{
    reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    _minTimer = [NSTimer scheduledTimerWithTimeInterval:minUpdateTime target:self selector:@selector(enableRetrieve) userInfo:nil repeats:YES];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(retrieveAppDataAndSaveToFile) userInfo:nil repeats:YES];
    [_timer fire];
}


- (void)stopUpdating
{
    [_minTimer invalidate];
    [_timer invalidate];
    [reachability stopMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)enableRetrieve
{
    _shouldRetrieve = YES;
}


- (void)retrieveAppDataAndSaveToFile
{
    if(_shouldRetrieve == NO)
        return;
    
    NSLog(@"Retrieving Data");
    _shouldRetrieve = NO;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    for(NSString* keyName in [self keyNames])
    {
        NSString* requestString = [NSString stringWithFormat:@"https://shane-hackthenorth.firebaseio.com/%@.json", keyName];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        [request setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if(connectionError)
            {
                NSLog(@"Connection ERROR: %@", connectionError);
                if(self.displayAlert && !_alertDisplayed)
                {
                    _shouldRetrieve = YES;
                    _alertDisplayed = YES;
                    [[[UIAlertView alloc] initWithTitle:@"Offline Mode" message:[NSString stringWithFormat:@"App cannot update information at this time because %@.", connectionError.localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
                }
                return;
            }
            
            [self saveData:data toFileWithName:[NSString stringWithFormat:@"%@.json", keyName]];
            
        }];
        
        [self performSelectorOnMainThread:@selector(postNeedUpdateDataNotification) withObject:nil waitUntilDone:YES];
    }

    
    
    
}



- (void)saveFromOfflineIfNoFile
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary* fileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for(NSString* keyName in [self keyNames])
    {
        NSArray* keyArray = [fileDictionary objectForKey:keyName];
        
        NSData* localData = [NSJSONSerialization dataWithJSONObject:keyArray options:0 error:nil];
        
        [self saveData:localData toFileWithName:[NSString stringWithFormat:@"%@.json", keyName]];
    }
    
    [self performSelectorOnMainThread:@selector(postNeedUpdateDataNotification) withObject:nil waitUntilDone:YES];
}


- (void)saveData: (NSData*)data toFileWithName: (NSString*)filename
{
    if(!data || !filename)
    {
        NSLog(@"File Data Missing, can't save");
        return;
    }
    
//    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    NSURL* fileURL = [url URLByAppendingPathComponent:filename];
    
    [[NSFileManager defaultManager] createFileAtPath:[fileURL path] contents:data attributes:nil];

}


- (id)retrieveArrayOrDictFromFile: (NSString*)fileName
{
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];

    NSURL* fileURL = [url URLByAppendingPathComponent:fileName];
    NSData* fileData = [[NSFileManager defaultManager] contentsAtPath:[fileURL path]];
    
    if(!fileData) //if Offline
    {
        [self saveFromOfflineIfNoFile];
        fileData = [[NSFileManager defaultManager] contentsAtPath:[fileURL path]];
    }
    
    id fileArrayOrDict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
    
    return fileArrayOrDict;
}





- (void)postNeedUpdateDataNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedUpdateDataNotification object:self];
    
}


- (void)networkStatusChanged: (NSNotification*)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    NSNumber* value = [userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    if([value integerValue] == AFNetworkReachabilityStatusReachableViaWiFi || [value integerValue] == AFNetworkReachabilityStatusReachableViaWWAN)
    {
        _alertDisplayed = NO;
        [self retrieveAppDataAndSaveToFile];
    }
    
}










@end
