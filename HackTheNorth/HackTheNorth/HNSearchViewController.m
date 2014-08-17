//
//  HNSortingViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNSearchViewController.h"
#import "UserInterfaceConstants.h"
#import "HNDataManager.h"
#import "JPStyle.h"
#import "JPFont.h"


@interface HNSearchViewController ()

@end

@implementation HNSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, 44)];
    
    _searchBar.delegate = self;
    _searchBar.tintColor = [JPStyle interfaceTintColor];
    _searchBar.translucent = YES;
    
    _searchBar.placeholder = @"Filter for All Fields";
    [self.view addSubview:_searchBar];
    
    [[UISearchBar appearance] setTintColor:[JPStyle interfaceTintColor]];
    
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

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
    [self.tableView reloadData];
}


- (NSArray*)searchFromDictArray:(NSArray*)array bySearchTerm: (NSString*)term
{
    term = [term lowercaseString];
    
    NSMutableArray* newArray = [NSMutableArray array];
 
    NSArray* stringSearches = @[@"company", @"contact", @"name", @"organization", @"email", @"phone", @"twitter"];
    //not searching: @"description"
    NSArray* arrayOfStringSearches = @[@"prize", @"skills", @"role", @"availability"];
    
    for(NSDictionary* cellDict in self.origCellDictArray)
    {
        for(NSString* stringKey in stringSearches)
        {
            id stringValue = [cellDict objectForKey: stringKey];
            
            if(!stringValue || ![stringValue isKindOfClass:[NSString class]])
                continue;
            
            NSString* value = [(NSString*)stringValue lowercaseString];
            
            //if term matches and Cell haven't been added yet, add it
            if(!([value rangeOfString: term].location==NSNotFound) && ![newArray containsObject:cellDict])
            {
                [newArray addObject:[cellDict copy]];
            }
            
        }
        
        for(NSString* stringKey in arrayOfStringSearches)
        {
            NSArray* stringArrayId = [cellDict objectForKey:stringKey];
            
            if(!stringArrayId || ![stringArrayId isKindOfClass:[NSArray class]])
                continue;
                                   
            NSArray* stringArray = (NSArray*)stringArrayId;
            
            for(id stringValue in stringArray)
            {
                if(!stringValue || ![stringValue isKindOfClass:[NSString class]])
                    continue;
                
                NSString* value = [(NSString*)stringValue lowercaseString];
                
                //if term matches and Cell haven't been added yet, add it
                if(!([value rangeOfString: term].location==NSNotFound) && ![newArray containsObject:cellDict])
                {
                    [newArray addObject:[cellDict copy]];
                }
            }
        }
        
    }
    
    return [newArray copy];
}



#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText
{
    [self reloadDataForFiltering];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.cellDictArray = [self.origCellDictArray copy];
    [searchBar resignFirstResponder];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
}



#pragma mark - Setter Methods

- (void)setOrigCellDictArray:(NSArray *)origCellDictArray
{
    _origCellDictArray = origCellDictArray;
    
}







@end
