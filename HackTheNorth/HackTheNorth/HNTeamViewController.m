//
//  HNTeamViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNTeamViewController.h"
#import "UserInterfaceConstants.h"
#import "HNScrollListCell.h"
#import "HNDataManager.h"

static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";

@implementation HNTeamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[HNDataManager alloc] init];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HNScrollListCell class] forCellReuseIdentifier:kHNScrollListCellIdentifier];
    
    [self.view addSubview: self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
    
    [self reloadData];
}


- (void)reloadData
{
    _infoArray = [manager retrieveArrayFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][4]]];
    [self.tableView reloadData];
}


#pragma mark - UI Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_infoArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView dequeueReusableCellWithIdentifier:kHNScrollListCellIdentifier];

    NSDictionary* infoDict = [_infoArray objectAtIndex:indexPath.row];
    
    cell.title = [infoDict objectForKey:@"name"];
    cell.subtitle = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"twitter"]];
    cell.detailList = [infoDict objectForKey:@"role"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
