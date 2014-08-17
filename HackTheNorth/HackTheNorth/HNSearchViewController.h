//
//  HNSortingViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNSearchViewController : UIViewController <UISearchBarDelegate>
{
    UISearchBar* _searchBar;
    

}



@property (nonatomic, strong) UITableView* tableView;

@property (atomic, strong) NSArray* origCellDictArray;
@property (atomic, strong) NSArray* cellDictArray;


- (void)reloadDataForFiltering;



@end
