//
//  HNScrollListCell.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNAvatarView, AutoScrollLabel, HNScrollView;
@interface HNScrollListCell : UITableViewCell <UIGestureRecognizerDelegate>
{
    HNAvatarView* avatarView;
    
    AutoScrollLabel* titleLabel;
    UILabel* subtitleLabel;
    HNScrollView*  scrollListView;
    
    
}



@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subtitle;

@property (nonatomic, strong) NSArray* detailList; //array of NSString names;





@end
