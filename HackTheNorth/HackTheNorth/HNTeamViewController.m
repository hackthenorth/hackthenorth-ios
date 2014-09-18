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
#import "NSString+HNConvenience.h"
#import "HNAvatarView.h"
#import "JPStyle.h"

static NSString *const TEAM_PATH = @"/team/";

static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";

@implementation HNTeamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[HNDataManager alloc] init];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44) style:UITableViewStylePlain];
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
    
    [self reloadData:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:TEAM_PATH object:nil];
    [HNDataManager loadDataForPath:TEAM_PATH];
}


- (void)reloadData:(NSNotification *)notification
{
    NSArray* headersArray =
    @[
      @{ @"name":@"Kartik Talwar", @"email":@"kartik@hackthenorth.com", @"phone":@"+1 (647) 225-4089", @"twitter": @"@TheRealKartik", @"role":@[@"Organizer"]},
      @{ @"name":@"Kevin Lau", @"email":@"kevin@hackthenorth.com", @"phone":@"+1 (647) 627-8630", @"twitter": @"@thekevlau", @"role":@[@"Organizer"]}
      ];
    
    NSDictionary* infoDict = [notification userInfo][HNDataManagerKeyData];
//    if(!infoDict)
//        return;
    
    NSMutableArray* array = [NSMutableArray array];
    NSArray* keyArray = [infoDict allKeys];
    for(NSString* key in keyArray)
    {
        NSMutableDictionary* dictionary = [[infoDict objectForKey:key] mutableCopy];
        [dictionary setObject:key forKey:@"id"];
        [array addObject:dictionary];
    }
    
    self.origCellDictArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        
        NSString* name1 = @"zzzzzz";
        NSString* name2 = @"zzzzzz";
        
        if([obj1 objectForKey:@"id"])
            name1 = [obj1 objectForKey:@"id"];
        
        if([obj2 objectForKey:@"id"])
            name2 = [obj2 objectForKey:@"id"];
        return [name1 compare:name2];
    }];
    
    // We want the headers to be located at the top of the cellDictArray.
    NSArray* appendedArray = [headersArray arrayByAddingObjectsFromArray:self.origCellDictArray];
    
    self.origCellDictArray = [appendedArray copy];
    self.cellDictArray = [appendedArray copy];
    
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
        NSString* theSubtitle = [infoDict objectForKey:@"twitter"];
        cell.subtitle = theSubtitle;
        cell.detailList = [infoDict objectForKey:@"role"];
        cell.imageURL = [NSURL URLWithString:[infoDict objectForKey:@"avatar"]];
        cell.email = [infoDict objectForKey:@"email"];
        
        id phoneId = [infoDict objectForKey:@"phone"];
        if([phoneId isKindOfClass:[NSNumber class]])
            cell.phone = (NSNumber*)phoneId;
        else if([phoneId isKindOfClass:[NSString class]])
            cell.phone = [(NSString*)phoneId convertFromPhoneStringToNumber];

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
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44);
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
