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
#import "DejalActivityView.h"


@implementation HNScheduleViewController

static NSString* const SCHEDULE_PATH = @"/schedule/";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionTitles = @[@"Friday Event", @"Saturday Event", @"Sunday Event"];
    manager = [[HNDataManager alloc] init];
    
    
    _searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchIcon"] style: UIBarButtonItemStylePlain target:self action:@selector(searchButtonPressed:)];
    _searchItem.tag = 0;
    self.navigationItem.rightBarButtonItem = _searchItem;
    
    [self.view sendSubviewToBack:_searchBar];
    _searchBar.alpha = 0;
    
    NSDateComponents* startComp = [[NSDateComponents alloc] init];
    [startComp setDay:20];
    [startComp setMonth:9];
    [startComp setYear:2014];
    [startComp setHour:0];
    
    NSDateComponents* endComp = [[NSDateComponents alloc] init];
    [endComp setDay:21];
    [endComp setMonth:9];
    [endComp setYear:2014];
    [endComp setHour:10];
    
    NSDate* startDate = [[NSCalendar currentCalendar] dateFromComponents:startComp];
    NSDate* endDate = [[NSCalendar currentCalendar] dateFromComponents:endComp];

    
    self.scheduleView = [[HNScheduleProgressView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+ kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 90) startDate:startDate endDate:endDate];
    
    [self.view addSubview:self.scheduleView];
    
    
    _searchBar.frame = self.scheduleView.frame;
    self.cellDictArray = @[];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 90, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait - 90) style:UITableViewStyleGrouped];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = self.tableView.frame;
        frame.size.height -= 88;
        self.tableView.frame = frame;
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[HNScheduleTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:SCHEDULE_PATH object:nil];
    [HNDataManager loadDataForPath:SCHEDULE_PATH];
}


- (void)reloadData:(NSNotification *)notification
{
    NSDictionary* infoDict = [notification userInfo][HNDataManagerKeyData];
    
    if(!infoDict)
        return;
    
    NSMutableArray* array = [[infoDict allValues] mutableCopy];
    
    self.cellDictArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        
        NSDate* date1 = nil;
        NSDate* date2 = nil;
        
        if([obj1 objectForKey:@"start_time"])
        {
            NSString* time1 = [obj1 objectForKey:@"start_time"];
            date1 = [NSDate dateWithISO8601CompatibleString:time1];
        }
        
        if([obj1 objectForKey:@"start_time"])
        {
            NSString* time2 = [obj2 objectForKey:@"start_time"];
            date2 = [NSDate dateWithISO8601CompatibleString:time2];
        }
        
        if(date1 && date2)
        {
            return [date1 compare:date2];
        }
        else {
            return NSOrderedAscending;
        }
        
    }];

    self.origCellDictArray = [self.cellDictArray copy];
    
    _friSatSunArray = [NSMutableArray arrayWithObjects:[@[] mutableCopy],[@[]mutableCopy],[@[]mutableCopy], nil];
    
    for(NSDictionary* dict in self.cellDictArray)
    {
        NSString* start_time = [dict objectForKey:@"start_time"];
        NSDate* startDate = [NSDate dateWithISO8601CompatibleString:start_time];
        NSInteger friSatSunInt = [startDate friSatSunInteger];
        if(friSatSunInt != -1)
            [_friSatSunArray[friSatSunInt] addObject:dict];
    }
    
    [self reloadDataForFiltering];
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
        cell.endTime = [infoDict objectForKey:@"end_time"];
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



#pragma mark UI Navigation Controller

- (void)searchButtonPressed:(UIBarButtonItem*)button
{
    if(button.tag == 0)//search was pressed
    {
        _searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"timerIcon"] style: UIBarButtonItemStylePlain target:self action:@selector(searchButtonPressed:)];
        _searchItem.tag = 1;
        self.navigationItem.rightBarButtonItem = _searchItem;
        /////////////////////////////
        [self searchBarTextDidBeginEditing:_searchBar];
        
        [UIView animateWithDuration:0.5 animations:^{
            //show search bar
            _searchBar.alpha = 1.0;
        }];
        [self.view bringSubviewToFront:_searchBar];
    }
    else //timer pressed
    {
        _searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchIcon"] style: UIBarButtonItemStylePlain target:self action:@selector(searchButtonPressed:)];
        _searchItem.tag = 0;
        self.navigationItem.rightBarButtonItem = _searchItem;
        ////////////////////////////////
        [self endSearchingWithSearchBar:_searchBar];
        
        [UIView animateWithDuration:0.5 animations:^{
            _searchBar.alpha = 0;
        }];
        [self.view sendSubviewToBack:_searchBar];
    }
    
}


- (void)reloadDataForFiltering
{
    if([_searchBar.text isEqual:@""])
    {
        self.cellDictArray = [self.origCellDictArray copy];
    }
    else
    {
        NSArray* resultArray = [self searchFromDictArray:self.origCellDictArray bySearchTerm:_searchBar.text];
        self.cellDictArray = resultArray;
    }
    
    _friSatSunArray = [NSMutableArray arrayWithObjects:[@[] mutableCopy],[@[]mutableCopy],[@[]mutableCopy], nil];
    
    for(NSDictionary* dict in self.cellDictArray)
    {
        NSString* start_time = [dict objectForKey:@"start_time"];
        NSDate* startDate = [NSDate dateWithISO8601CompatibleString:start_time];
        NSInteger friSatSunInt = [startDate friSatSunInteger];
        if(friSatSunInt != -1)
            [_friSatSunArray[friSatSunInt] addObject:dict];
    }
    
    [self.tableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];

    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, kiPhoneWidthPortrait, kiPhoneHeightPortrait- kiPhoneKeyboardHeightPortrait - 159);
        if(![JPStyle iPhone4Inch])
        {
            CGRect frame = self.tableView.frame;
            frame.size.height -= 88;
            self.tableView.frame = frame;
        }
        
    } completion:nil];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.tableView.frame = CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 90, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait - 90);
        if(![JPStyle iPhone4Inch])
        {
            CGRect frame = self.tableView.frame;
            frame.size.height -= 88;
            self.tableView.frame = frame;
        }
    } completion:nil];
    

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
