//
//  AppDelegate.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "AppDelegate.h"
#import "HNDataManager.h"
#import "NSString+HNConvenience.h"
#import <Parse/Parse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    dataManager = [[HNDataManager alloc] init];
    dataManager.displayAlert = YES;
    [dataManager startUpdating];
    

    
    return YES;
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    //Parse
    [Parse setApplicationId:@"37qNFOlw7SmK2tfC7Oh8Q0GWR6159s5ORgqmyPHb"
                  clientKey:@"BcmjT6uyWqcGMrvTOxTwy8sQKxJWdZWZLsPk9LFC"];
    
    //vdyPmKmbio8rrr8G3XUPzN5WKKCGbSYzUQlJ4l4r   (REST API key)
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
    
    
    //Send to Firebase
    NSString* serializedStr = [NSString serializeDeviceToken:deviceToken];
    NSDictionary* tokenDictionary = @{serializedStr : @"dummy"};
    
    NSData* tokenData = [NSJSONSerialization dataWithJSONObject:tokenDictionary options:false error:nil];
    
    NSURL* putURL = [NSURL URLWithString:@"https://shane-hackthenorth.firebaseio.com/notifications/ios.json"];
    NSMutableURLRequest* putReq = [NSMutableURLRequest requestWithURL:putURL];
    
    putReq.HTTPMethod = @"PATCH";
    putReq.HTTPBody = tokenData;
    
    [NSURLConnection sendAsynchronousRequest:putReq queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        NSLog(@"status code: %d", httpResponse.statusCode);
        
    }];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}






@end
