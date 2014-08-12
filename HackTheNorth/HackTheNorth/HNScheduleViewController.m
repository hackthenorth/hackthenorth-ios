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
#import "HNScheduleDetailViewController.h"
#import "HNDataManager.h"
#import "NSDate+HNConvenience.h"

@implementation HNScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionTitles = @[@"Friday Event", @"Saturday Event", @"Sunday Event"];
    
    manager = [[HNDataManager alloc] init];
    _infoArray = @[];
    
    NSDateComponents* startComp = [[NSDateComponents alloc] init];
    [startComp setDay:20];
    [startComp setMonth:9];
    [startComp setYear:2014];
    [startComp setHour:0];
    
    NSDateComponents* endComp = [[NSDateComponents alloc] init];
    [endComp setDay:21];
    [endComp setMonth:9];
    [endComp setYear:2014];
    [endComp setHour:11];
    
    NSDate* startDate = [[NSCalendar currentCalendar] dateFromComponents:startComp];
    NSDate* endDate = [[NSCalendar currentCalendar] dateFromComponents:endComp];

    
    self.scheduleView = [[HNScheduleProgressView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 90) startDate:startDate endDate:endDate];
    
    [self.view addSubview:self.scheduleView];
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 90, kiPhoneWidthPortrait, 5)];
    blueBar.backgroundColor = [JPStyle colorWithName:@"blue"];
    [self.view addSubview:blueBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 95, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait - 95) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[HNScheduleTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
}


- (void)reloadData
{
    _infoArray = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][1]]];
    
    _friSatSunArray = [NSMutableArray arrayWithObjects:[@[] mutableCopy],[@[]mutableCopy],[@[]mutableCopy], nil];
    
    for(NSDictionary* dict in _infoArray)
    {
        NSString* start_time = [dict objectForKey:@"start_time"];
        NSDate* startDate = [NSDate dateWithISO8601CompatibleString:start_time];
        NSInteger friSatSunInt = [startDate friSatSunInteger];
        if(friSatSunInt != -1)
            [_friSatSunArray[friSatSunInt] addObject:dict];
    }
    
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_friSatSunArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friSatSunArray[section] count];
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNScheduleTableViewCell* cell = (HNScheduleTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    NSDictionary* infoDict = _friSatSunArray[indexPath.section][indexPath.row];
    
    if(![infoDict isEqual: [NSNull null]])
    {
        cell.name = [infoDict objectForKey:@"name"];
        cell.location = [infoDict objectForKey:@"location"];

        cell.startTime = [infoDict objectForKey:@"start_time"];
        cell.speaker = [infoDict objectForKey:@"speaker"];
        cell.descriptor = [infoDict objectForKey:@"description"];
        cell.type = [infoDict objectForKey:@"type"];
    }
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitles[section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNScheduleDetailViewController* detailContorller=  [[HNScheduleDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    detailContorller.cell = [(HNScheduleTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath] copy];
    detailContorller.title = _sectionTitles[indexPath.section];
    
    [self.navigationController pushViewController:detailContorller animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
