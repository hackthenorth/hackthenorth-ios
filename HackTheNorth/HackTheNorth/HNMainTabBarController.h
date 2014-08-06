//
//  HNMainTabBarController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNMainTabBarController : UITabBarController
{
    UIView*  whiteView;
    
    NSTimer* gearTimer;
    int      gearSide;
    
    CGFloat  originalImageWidth;
}


@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, strong) UIImageView* gearView;



@end
