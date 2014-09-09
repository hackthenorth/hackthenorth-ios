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
    
    AutoScrollLabel* titleLabel;
    UILabel* subtitleLabel;
    // can be skills, roles, prizes depending on the controller
    AutoScrollLabel* itemsLabel;
    
}



@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subtitle;


@property (nonatomic, strong) HNAvatarView* avatarView;
@property (nonatomic, assign) BOOL shouldShowAvatarLetter;
@property (nonatomic, strong) NSURL* imageURL;

@property (nonatomic, strong) NSArray* detailList; //array of NSString names;

@property (nonatomic, strong) NSArray* availability;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSNumber* phone;
@property (nonatomic, strong) NSString* github;

@property (nonatomic, strong) NSString* descriptor;


+ (CGFloat)getCellHeight;

@end
