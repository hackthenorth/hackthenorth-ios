//
//  FirstViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNUpdatesViewController.h"
#import "UserInterfaceConstants.h"
#import "HNUpdatesTableViewCell.h"
#import "JPStyle.h"
#import "HNDataManager.h"
#import "NSDate+HNConvenience.h"
#import "DejalActivityView.h"
#import "HNSponsorsViewController.h"
#import "HNCampusMapViewController.h"


@interface HNUpdatesViewController ()
            

@end


@implementation HNUpdatesViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
     manager = [[HNDataManager alloc] init];
    _infoDict = [NSDictionary dictionary];

    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Sponsors" style:UIBarButtonItemStylePlain target:self action:@selector(sponsorButtonPressed)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapButtonPressed)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIView* blueBar = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight + kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 5)];
    blueBar.backgroundColor = [JPStyle interfaceTintColor];
    [self.view addSubview:blueBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+5, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = self.tableView.frame;
        frame.size.height -= 88;
        self.tableView.frame = frame;
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HNUpdatesTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNeedUpdateDataNotification object:nil];
    
    [self reloadData];
}


- (void)reloadData
{
    NSDictionary* updateDict = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][0]]];
    
    if(!updateDict)
    {
        _reUpdateLocallyTimer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
        return;
    }
    
    _infoDict = updateDict;
    
    NSArray* unArray = [_infoDict allValues];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        _infoArray = [[unArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
            
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
        }] mutableCopy];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self reloadTableView];
        });
        
    });
    
}


- (void)reloadTableView
{
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



#pragma mark - Navigation Controller Methods

- (void)sponsorButtonPressed
{
    HNSponsorsViewController* sponsorsController = [[HNSponsorsViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:sponsorsController animated:YES];
    
}



- (void)mapButtonPressed
{
    
    HNCampusMapViewController* mapController = [[HNCampusMapViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:mapController animated:YES];
    
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
