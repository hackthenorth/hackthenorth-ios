//
//  HNMentorsViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNMentorsViewController.h"
#import "UserInterfaceConstants.h"
#import "HNScrollListCell.h"
#import "HNDataManager.h"
#import "HNMentorsDetailsViewController.h"
#import "JPStyle.h"
#import "NSString+HNConvenience.h"

static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";

NSString *MENTORS_PATH = @"/mentors/";

@implementation HNMentorsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[HNDataManager alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+44, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44) style:UITableViewStylePlain];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = self.tableView.frame;
        frame.size.height -= 88;
        self.tableView.frame = frame;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HNScrollListCell class] forCellReuseIdentifier:kHNScrollListCellIdentifier];
    [self.view addSubview: self.tableView];
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:MENTORS_PATH object:nil];
    [HNDataManager loadDataForPath:MENTORS_PATH];
}


- (void)reloadData:(NSNotification *)notification
{
    NSDictionary* infoDict = [notification userInfo][HNDataManagerKeyData];
    
    if(!infoDict)
        return;
    
    NSMutableArray* array = [[infoDict allValues] mutableCopy];
    
    self.origCellDictArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        
        NSString* name1 = @"zzzzzz";
        NSString* name2 = @"zzzzzz";
        
        if([obj1 objectForKey:@"name"])
            name1 = [obj1 objectForKey:@"name"];
        
        if([obj2 objectForKey:@"name"])
            name2 = [obj2 objectForKey:@"name"];
        return [name1 compare:name2];
    }];

    self.cellDictArray = [self.origCellDictArray copy];
    [self reloadDataForFiltering];
}



#pragma mark - UI Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellDictArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView dequeueReusableCellWithIdentifier:kHNScrollListCellIdentifier];
    cell.backgroundColor = [JPStyle colorWithHex:@"FFFFFF" alpha:1]; //DE6" alpha:1];
    
    
    NSDictionary* infoDict = [self.cellDictArray objectAtIndex:indexPath.row];
    
    if(![infoDict isEqual: [NSNull null]])
    {
        cell.title =  [infoDict objectForKey:@"name"];
        cell.subtitle = [infoDict objectForKey:@"organization"];
        cell.detailList = [infoDict objectForKey:@"skills"];
        cell.email = [infoDict objectForKey:@"email"];
        cell.github = [infoDict objectForKey:@"github"];
        cell.phone = [[infoDict objectForKey:@"phone"] convertFromPhoneStringToNumber];
        NSString* urlString = [infoDict objectForKey:@"image"];
        NSURL* url = [NSURL URLWithString:urlString];
        
        cell.imageURL = url;
        cell.availability = [infoDict objectForKey:@"availability"];
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HNScrollListCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNMentorsDetailsViewController* detailController =[[HNMentorsDetailsViewController alloc] initWithCell:(HNScrollListCell*)[self.tableView cellForRowAtIndexPath:indexPath]];
    
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    
}


#pragma mark - Search Bar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44+kiPhoneTabBarHeight-kiPhoneKeyboardHeightPortrait);
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
        self.tableView.frame = CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 44, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44);
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
