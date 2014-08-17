//
//  HNMainTabBarController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNMainTabBarController.h"
#import "UserInterfaceConstants.h"
#import "JPStyle.h"

@implementation HNMainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kiPhoneWidthPortrait-240)/2.0, (kiPhoneHeightPortrait-240)/2.0, 240, 240)];
    originalImageWidth = self.imageView.frame.size.width;
    self.imageView.center = CGPointMake(kiPhoneWidthPortrait/2.0, kiPhoneHeightPortrait/2.0);
    self.imageView.image = [UIImage imageNamed:@"iconWithoutGear"];
    
    self.gearView = [[UIImageView alloc] initWithFrame:CGRectMake(76, 146, 33, 33)];
    self.gearView.image = [UIImage imageNamed:@"iconGear"];
    [self.imageView addSubview:self.gearView];
    
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:self.imageView];
    [self.view addSubview:whiteView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(revealViewController) withObject:nil afterDelay:2];
    
    gearSide = 0;
    gearTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(spinGear) userInfo:nil repeats:YES];
}


- (void)spinGear
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        if(gearSide==0)
        {
            self.gearView.transform = CGAffineTransformMakeRotation(M_PI*2/3);
            gearSide = 1;
        } else if(gearSide ==1){
            self.gearView.transform = CGAffineTransformMakeRotation(M_PI*4/3);
            gearSide = 2;
        } else {
            self.gearView.transform = CGAffineTransformMakeRotation(0);
            gearSide = 0;
        }

    } completion:nil];
}


- (void)revealViewController
{
    
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.imageView.frame = CGRectMake((kiPhoneWidthPortrait-1000)/2.0, (kiPhoneHeightPortrait-1000)/2.0, 1000, 1000);
        CGFloat scale = self.imageView.frame.size.width / originalImageWidth;
        self.gearView.frame = CGRectMake(76*scale, 146*scale, 33*scale, 33*scale);
        
        whiteView.alpha = 0;
        
    } completion:^(BOOL finished){
        [JPStyle applyGlobalStyle];
        self.tabBar.tintColor = [JPStyle interfaceTintColor];
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }];
    
    [gearTimer performSelector:@selector(invalidate) withObject:nil afterDelay:2];
}







@end
