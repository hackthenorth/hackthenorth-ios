//
//  HNSortingViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNSearchViewController : UITableViewController <UISearchBarDelegate>
{
    @protected
    UISearchBar* _searchBar;
    
}


@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSArray* origCellDictArray;
@property (nonatomic, strong) NSArray* cellDictArray;



- (void)reloadDataForFiltering;
- (NSArray*)searchFromDictArray:(NSArray*)array bySearchTerm: (NSString*)term;

- (void)endSearchingWithSearchBar: (UISearchBar *)searchBar;

@end
