//
//  HNMentorsDetailsViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class HNScrollListCell, HNAvatarView, HNBorderButton;
@interface HNMentorsDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    UILabel* nameLabel;
    HNAvatarView* imageView;

    UILabel* org;
    UITextView* avai;
    UITextView* skillVal;
    UILabel* git;
    
    MFMailComposeViewController* mailController;
    
    HNBorderButton* phoneButton;
    HNBorderButton* sendEmailButton;
}




@property (nonatomic, strong) HNScrollListCell* cell;



- (id)initWithCell: (HNScrollListCell*)cell;


@end
