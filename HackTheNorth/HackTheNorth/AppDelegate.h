//
//  AppDelegate.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNDataManager;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HNDataManager* dataManager;
}


@property (strong, nonatomic) UIWindow *window;


@end

