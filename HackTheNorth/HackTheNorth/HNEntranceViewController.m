//
//  HNEntranceViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/6/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNEntranceViewController.h"

@implementation HNEntranceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.imageView.image = [UIImage imageNamed:@"logo"];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(presentViewController) userInfo:nil repeats:NO];
    
    [UIView animateWithDuration:1 animations:^{
        self.imageView.alpha = 0;
    }];
    
}




- (void)presentViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    
}







@end
