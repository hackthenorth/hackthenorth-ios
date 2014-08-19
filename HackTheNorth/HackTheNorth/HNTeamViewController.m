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
#import "SVStatusHUD.h"
#import "HNTeamDetailsViewController.h"

static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";

@implementation HNTeamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[HNDataManager alloc] init];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+44, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44) style:UITableViewStylePlain];
    
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
    NSDictionary* infoDict = [manager retrieveArrayOrDictFromFile:[NSString stringWithFormat:@"%@.json",[manager keyNames][4]]];
    
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
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView dequeueReusableCellWithIdentifier:kHNScrollListCellIdentifier];

    NSDictionary* infoDict = [self.cellDictArray objectAtIndex:indexPath.row];
    
    if(![infoDict isEqual: [NSNull null]])
    {
        cell.title = [infoDict objectForKey:@"name"];
        cell.subtitle = [NSString stringWithFormat:@"%@",[infoDict objectForKey:@"twitter"]];
        cell.detailList = [infoDict objectForKey:@"role"];
        cell.imageURL = [NSURL URLWithString:[infoDict objectForKey:@"image"]];
        cell.email = [infoDict objectForKey:@"email"];
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
    
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    HNTeamDetailsViewController* detailsController = [[HNTeamDetailsViewController alloc] initWithCell:cell];
    [self.navigationController pushViewController:detailsController animated:YES];
    
}




- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Search Bar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44+kiPhoneTabBarHeight-kiPhoneKeyboardHeightPortrait);
    } completion:nil];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight + 44, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44);
    } completion:nil];
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
