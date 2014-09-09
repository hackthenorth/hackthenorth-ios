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
#import "UIViewController+ScrollingNavbar.h"


@interface HNScheduleViewController ()

@property (nonatomic, assign) BOOL isSearching;

@end

@implementation HNScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionTitles = @[@"Friday Event", @"Saturday Event", @"Sunday Event"];
    manager = [[HNDataManager alloc] init];
    
    //_searchBar.alpha = 0;
    
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
    self.scheduleView.backgroundColor = [UIColor whiteColor];
    self.scheduleView.layer.borderWidth = 0.5;
    self.scheduleView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    [self.tableView setTableHeaderView:_searchBar];
    
    self.cellDictArray = @[];
    
    [self.tableView registerClass:[HNScheduleTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    

    //[self followScrollView:self.tableView withDelay:60];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
    


    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 && !self.isSearching){
        return  self.scheduleView;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 && !self.isSearching){
        return self.scheduleView.frame.size.height;
    } else if (self.isSearching){
        return 0;
    }
    return 25;
}

- (void)reloadData
{
    NSDictionary* infoDict = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][1]]];
    
    if(!infoDict)
        return;
    
    NSMutableArray* array = [[infoDict allValues] mutableCopy];
    
    self.cellDictArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        
        NSString* name1 = @"zzzzzz";
        NSString* name2 = @"zzzzzz";
        
        if([obj1 objectForKey:@"name"])
            name1 = [obj1 objectForKey:@"name"];
        
        if([obj2 objectForKey:@"name"])
            name2 = [obj2 objectForKey:@"name"];
        return [name1 compare:name2];
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
    self.isSearching = YES;
    [self.tableView reloadData];

}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
    self.isSearching = NO;
    [self.tableView reloadData];
    

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isSearching = NO;
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
