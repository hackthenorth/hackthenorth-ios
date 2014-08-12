//
//  FirstViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNUpdatesViewController.h"
#import "UserInterfaceConstants.h"
#import "HNBannerView.h"
#import "HNUpdatesTableViewCell.h"
#import "JPStyle.h"
#import "HNDataManager.h"
#import "NSDate+HNConvenience.h"

@interface HNUpdatesViewController ()
            

@end


@implementation HNUpdatesViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
     manager = [[HNDataManager alloc] init];
    _infoDict = [NSDictionary dictionary];
    
    self.banner = [[HNBannerView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight, kiPhoneWidthPortrait, 150)];
    self.banner.imgNameArray = [@[@"hackTheNorthBanner", @"hackersBanner", @"hoursBanner", @"locationBanner"] mutableCopy];
    [self.view addSubview:self.banner];
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, kiPadStatusBarHeight+150, kiPhoneWidthPortrait, 5)];
    blueBar.backgroundColor = [JPStyle colorWithName:@"blue"];
    [self.view addSubview:blueBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.banner.frame) + 5, kiPhoneWidthPortrait, 568-20-155-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HNUpdatesTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
    
    [self.banner activateAutoscroll];
    [self reloadData];
}


- (void)reloadData
{
    _infoDict = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][0]]];
    
    NSArray* keyNames = [_infoDict allKeys];
    _infoArray = [@[] mutableCopy];
    
    for(NSString* key in keyNames)
    {
        NSDictionary* tagDict = [_infoDict objectForKey:key];
        [_infoArray addObject:tagDict];
    }
    
    [_infoArray sortUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        NSDate* tagDate1 = [NSDate date];
        if([obj1 objectForKey:@"time"])
            tagDate1 = [NSDate dateWithISO8601CompatibleString:[obj1 objectForKey:@"time"]];
        
        NSDate* tagDate2 = [NSDate date];
        if([obj2 objectForKey:@"time"])
            tagDate2 = [NSDate dateWithISO8601CompatibleString:[obj2 objectForKey:@"time"]];
        
        NSTimeInterval interval = [tagDate1 timeIntervalSinceDate:tagDate2];
        
        if(interval > 0)
        {
            return NSOrderedAscending;
        } else if(interval < 0) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
                  
    [self.tableView reloadData];
}



#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_infoDict allKeys] count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNUpdatesTableViewCell* cell = [[HNUpdatesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    
    NSDictionary* tagDict = [_infoArray objectAtIndex:indexPath.row];
    
    cell.name = @"Hack The North";
    cell.date = [NSDate date];
    cell.message = @"No Message";
    
    if(![tagDict isEqual: [NSNull null]])
    {
        if([tagDict objectForKey:@"name"])
            cell.name = [tagDict objectForKey:@"name"];
        
        if([tagDict objectForKey:@"time"])
            cell.date = [NSDate dateWithISO8601CompatibleString:[tagDict objectForKey:@"time"]];
        
        if([tagDict objectForKey:@"description"])
            cell.message = [tagDict objectForKey:@"description"];
        
        if([tagDict objectForKey:@"avatar"])
            cell.avatarImgURL = [NSURL URLWithString:[tagDict objectForKey:@"avatar"]];
    }
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
