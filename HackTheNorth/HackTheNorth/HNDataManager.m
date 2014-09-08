//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNDataManager.h"
#import "SVStatusHUD.h"


#define minUpdateTime      10.0f
#define regularUpdateTime  20.0f

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


- (void)startUpdating
{
    reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    
    _minTimer = [NSTimer scheduledTimerWithTimeInterval:minUpdateTime target:self selector:@selector(enableRetrieve) userInfo:nil repeats:YES];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:regularUpdateTime target:self selector:@selector(retrieveAppDataAndSaveToFile) userInfo:nil repeats:YES];
    [_timer fire];
    
    
    _statusTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkNetworkStatus) userInfo:nil repeats:YES];
    
    _stopStatusTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopStatusTimer) userInfo:nil repeats:NO];
    
}


- (void)checkNetworkStatus
{
    BOOL reach = [reachability isReachable];
    if(reach)
    {
        NSLog(@"Reachable");
        [self retrieveAppDataAndSaveToFile];
        [_statusTimer invalidate];
        _statusTimer = nil;
    }
    else
    {
        NSLog(@"Not Reachable");
    }
}


- (void)stopStatusTimer
{
    [_statusTimer invalidate];
    _statusTimer = nil;
    [_stopStatusTimer invalidate];
    _stopStatusTimer = nil;
}

- (void)stopUpdating
{
    [_statusTimer invalidate];
    _statusTimer = nil;
    [_stopStatusTimer invalidate];
    _stopStatusTimer = nil;
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
    
    _currentKeyIndex = -1;
    _saveTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(private_retrieveAppDataForOneKey) userInfo:nil repeats:YES];
    
}


- (void)private_retrieveAppDataForOneKey
{
    _currentKeyIndex++;
    NSLog(@"retrieving...");
    if(_currentKeyIndex < [[self keyNames] count])
    {
        NSString* keyName = [[self keyNames] objectAtIndex: _currentKeyIndex];
        NSString* requestString = [NSString stringWithFormat:@"https://hackthenorth.firebaseio.com/mobile/%@.json", keyName];
        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
//        [_requests replaceObjectAtIndex:_currentKeyIndex withObject:_request];
        
        _connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:NO];
        _connection.accessibilityLabel = keyName;
//        [_connections replaceObjectAtIndex:_currentKeyIndex withObject:_connection];
        [_connection start];
        
    }
    else
    {
        //finished
        NSLog(@"Index: %d", _currentKeyIndex);
        [_saveTimer invalidate];
        _saveTimer = nil;
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    _savedFiles++;
    
    NSString* keyName = connection.accessibilityLabel;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL success = [self saveData:data toFileWithName:[NSString stringWithFormat:@"%@.json", keyName]];
        
        if(!success)
        {
            _saveSuccess = NO;
            NSLog(@"Saving File Failed");
            return;
        }
        
        if(_savedFiles == [[self keyNames] count]){
            [self postNeedUpdateDataNotification];
            _savedFiles = 0;
        }

    });
    
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSLog(@"Connection ERROR: %@", error.localizedDescription);
    if(self.displayAlert && !_alertDisplayed)
    {
        _shouldRetrieve = YES;
        _alertDisplayed = YES;
        
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"sync"] status:@"Sync Timed Out"];
    }
    
}



- (void)saveFromOfflineIfNoFile
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary* fileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    BOOL successful = YES;
    for(NSString* keyName in [self keyNames])
    {
        NSArray* keyArray = [fileDictionary objectForKey:keyName];
        
        NSData* localData = [NSJSONSerialization dataWithJSONObject:keyArray options:0 error:nil];
        
        BOOL indSuccess = [self saveData:localData toFileWithName:[NSString stringWithFormat:@"%@.json", keyName]];
        if(indSuccess==NO)
            successful = NO;
    }
    
    if(successful)
        [self performSelectorOnMainThread:@selector(postNeedUpdateDataNotification) withObject:nil waitUntilDone:YES];
}



- (BOOL)saveData: (NSData*)data toFileWithName: (NSString*)filename
{
    if(!data || !filename)
    {
        NSLog(@"File Data Missing, can't save");
        return NO;
    }
    
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    NSURL* fileURL = [url URLByAppendingPathComponent:filename];
    
    return [[NSFileManager defaultManager] createFileAtPath:[fileURL path] contents:data attributes:nil];

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
    if(_saveSuccess == YES)
        [[NSNotificationCenter defaultCenter] postNotificationName:kNeedUpdateDataNotification object:self];
    
    _saveSuccess = YES;
}


- (void)networkStatusChanged: (NSNotification*)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    NSNumber* value = [userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    if([value integerValue] == AFNetworkReachabilityStatusReachableViaWiFi || [value integerValue] == AFNetworkReachabilityStatusReachableViaWWAN)
    {
        [self retrieveAppDataAndSaveToFile];
        
        if(!_wifiStatusViewEnabled)
            _wifiStatusViewEnabled = YES;
        else
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"wifi"] status:@"Connected!"];
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Offline Mode"];
    }
    
}






@end
