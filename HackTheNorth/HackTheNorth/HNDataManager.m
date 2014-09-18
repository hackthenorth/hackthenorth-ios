//
//  HNDataManager.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/5/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNDataManager.h"
#import "SVStatusHUD.h"
#import "DejalActivityView.h"

const CGFloat REQUEST_TIMEOUT = 60.0f;

@implementation HNDataManager

+ (NSString *)getDataPathForPath:(NSString *) path {
    NSString *dataPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) objectAtIndex:0];
    return [dataPath stringByAppendingPathComponent:path];
}

+ (void)loadDataForPath:(NSString *)path {
    UIView* rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController].view;
    
    [DejalBezelActivityView activityViewForView:rootView withLabel:@"Loading" width:100];
    
    // Check for cached data, and notify with that if it exists.
    NSString *cachedFilePath = [HNDataManager getDataPathForPath:path];
    NSData *cachedData = [[NSFileManager defaultManager] contentsAtPath:cachedFilePath];
    if (cachedData) {
        id cachedJson = [NSJSONSerialization JSONObjectWithData:cachedData options:0 error:nil];
        if (cachedJson) {
            NSDictionary *info = @{ HNDataManagerKeyData : cachedJson };
            [[NSNotificationCenter defaultCenter] postNotificationName:path object:self userInfo:info];
        }
    }
    
    // Get the new data and post that in another notification.
    NSString *urlPath = [NSString stringWithFormat:@"https://hackthenorth.firebaseio.com/mobile/%@.json", path];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [DejalBezelActivityView removeViewAnimated:YES];
        
        id dataItem = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if(!dataItem)
        {
            NSLog(@"No Data Available");
            return ;
        }
        NSDictionary *info = @{ HNDataManagerKeyData : dataItem };
        [[NSNotificationCenter defaultCenter] postNotificationName:path object:self userInfo:info];
        
        // Save to cache if the data has changed.
        [[NSFileManager defaultManager] createFileAtPath:cachedFilePath contents:responseObject attributes:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DejalBezelActivityView removeViewAnimated:YES];
        NSLog(@"HTTP request error: %@", error);
    }];
}

@end
