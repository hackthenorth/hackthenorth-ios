//
//  HNScheduleViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScheduleViewController.h"
#import "UserInterfaceConstants.h"
#import "HNScheduleProgressView.h"
#import "HNScheduleTableViewCell.h"
#import "JPStyle.h"

@implementation HNScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionTitles = @[@"Friday Presentations", @"Saturday Presentations", @"Sunday Presentations"];
    
    
    
    NSDate* startDate = [NSDate dateWithTimeIntervalSinceNow:-9000];
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSinceNow:20000];
    
    self.scheduleView = [[HNScheduleProgressView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight, kiPhoneWidthPortrait, 100) startDate:startDate endDate:endDate];
    
    [self.view addSubview:self.scheduleView];
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, 120, kiPhoneWidthPortrait, 5)];
    blueBar.backgroundColor = [JPStyle colorWithName:@"blue"];
    [self.view addSubview:blueBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+105, kiPhoneWidthPortrait, kiPhoneHeightPortrait-120-kiPhoneTabBarHeight) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[HNScheduleTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNScheduleTableViewCell* cell = (HNScheduleTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitles[section];
}











@end
