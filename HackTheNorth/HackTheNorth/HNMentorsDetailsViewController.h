//
//  HNMentorsDetailsViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScrollListCell, HNAvatarView;
@interface HNMentorsDetailsViewController : UIViewController
{
    UILabel* nameLabel;
    HNAvatarView* imageView;

    UILabel* org;
    UITextView* avai;
    UITextView* skillVal;
    
}




@property (nonatomic, strong) HNScrollListCell* cell;



- (id)initWithCell: (HNScrollListCell*)cell;


@end
