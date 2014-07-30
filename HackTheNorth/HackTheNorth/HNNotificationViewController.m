//
//  FirstViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNNotificationViewController.h"
#import "UserInterfaceConstants.h"
#import "HNBannerView.h"
#import "HNNotificationTableViewCell.h"
#import "JPStyle.h"

@interface HNNotificationViewController ()
            

@end

@implementation HNNotificationViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.banner = [[HNBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight, kiPhoneWidthPortrait, 150)];
    self.banner.imgNameArray = [@[@"hackTheNorthBanner", @"hackersBanner", @"hoursBanner", @"locationBanner"] mutableCopy];
    [self.view addSubview:self.banner];
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+150, kiPhoneWidthPortrait, 5)];
    
    blueBar.backgroundColor = [JPStyle colorWithName:@"blue"];
    [self.view addSubview:blueBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.banner.frame) + 5, kiPhoneWidthPortrait, 568-20-155-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HNNotificationTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.banner activateAutoscroll];
}


#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HNNotificationTableViewCell* cell = [[HNNotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    
    
    
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}















- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.banner pauseAutoscroll];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
