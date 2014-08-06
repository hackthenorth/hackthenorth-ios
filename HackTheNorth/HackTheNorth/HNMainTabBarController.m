//
//  HNMainTabBarController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNMainTabBarController.h"
#import "UserInterfaceConstants.h"

@implementation HNMainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kiPhoneWidthPortrait-240)/2.0, (kiPhoneHeightPortrait-240)/2.0, 240, 240)];
    self.imageView.center = CGPointMake(kiPhoneWidthPortrait/2.0, kiPhoneHeightPortrait/2.0);
    self.imageView.image = [UIImage imageNamed:@"newLogo"];
    
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:self.imageView];
    [self.view addSubview:whiteView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        self.imageView.frame = CGRectMake((kiPhoneWidthPortrait-1000)/2.0, (kiPhoneHeightPortrait-1000)/2.0, 1000, 1000);
        self.imageView.center = CGPointMake(kiPhoneWidthPortrait/2.0, kiPhoneHeightPortrait/2.0);
        
        whiteView.alpha = 0;
    }];
    
}





@end
