//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNDataManager.h"




#define minUpdateTime  10.0f

@implementation HNDataManager

- (instancetype)init
{
    self = [super init];
    self.displayAlert = NO;
    _alertDisplayed = NO;
    _shouldRetrieve = YES;
    
    reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    return self;
}


- (NSArray*)keyNames
{
    return  @[@"updates", @"schedule", @"prizes", @"mentors", @"team"];
}


- (void)startUpdating
{
    _minTimer = [NSTimer scheduledTimerWithTimeInterval:minUpdateTime target:self selector:@selector(enableRetrieve) userInfo:nil repeats:YES];
    [_minTimer fire];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(retrieveAppDataAndSaveToFile) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)stopUpdating
{
    [_minTimer invalidate];
    [_timer invalidate];
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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://shane-hackthenorth.firebaseio.com/.json"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(connectionError)
        {
            NSLog(@"Connection ERROR: %@", connectionError);
            if(self.displayAlert && !_alertDisplayed)
            {
                _shouldRetrieve = YES;
                _alertDisplayed = YES;
                [[[UIAlertView alloc] initWithTitle:@"Offline Mode" message:[NSString stringWithFormat:@"App cannot update information at this time because %@", connectionError.localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
            }
            return;
        }
        
        NSDictionary* fileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for(NSString* keyName in [self keyNames])
        {
            NSArray* keyArray = [fileDictionary objectForKey:keyName];
            
            NSData* localData = [NSJSONSerialization dataWithJSONObject:keyArray options:0 error:nil];
            
            [self saveData:localData toFileWithName:[NSString stringWithFormat:@"%@.json", keyName]];
        }
        
        [self performSelectorOnMainThread:@selector(postNeedUpdateDataNotification) withObject:nil waitUntilDone:YES];

    }];
    
    
    
    
}



- (void)saveData: (NSData*)data toFileWithName: (NSString*)filename
{
    if(!data || !filename)
    {
        NSLog(@"File Data Missing, can't save");
        return;
    }
    
    NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    NSURL* fileURL = [url URLByAppendingPathComponent:filename];
    
    [[NSFileManager defaultManager] createFileAtPath:[fileURL path] contents:data attributes:nil];

}


- (NSArray*)retrieveArrayFromFile: (NSString*)fileName
{
    NSURL* url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];

    NSURL* fileURL = [url URLByAppendingPathComponent:fileName];
    
    NSData* fileData = [[NSFileManager defaultManager] contentsAtPath:[fileURL path]];
    
    NSArray* fileArray = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:nil];
    
    return fileArray;
}


- (NSDate*)dateWithISO8601CompatibleString: (NSString*)timestamp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSDate* date = [formatter dateFromString:timestamp];
    
    return date;
}



- (NSString*)timeStringFromDate: (NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:enUSPOSIXLocale];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString* string = [formatter stringFromDate:date];
    
    return string;
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
        [_timer fire];
    }
    
}


- (void)dealloc
{
    [reachability stopMonitoring];
}



@end
