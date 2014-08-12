//
//  HNPrizesViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNPrizesViewController.h"
#import "UserInterfaceConstants.h"
#import "HNScrollListCell.h"
#import "HNDataManager.h"


static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";

@implementation HNPrizesViewController


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
    [self reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
    
}


- (void)reloadData
{
    _infoArray = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][2]]];
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
    
    if(![infoDict isEqual: [NSNull null]])
    {
        cell.title = [infoDict objectForKey:@"name"];
        cell.subtitle = [infoDict objectForKey:@"company"];
        cell.detailList = [infoDict objectForKey:@"prize"];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"Cell Selected!");
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}





@end
