//
//  HNTeamDetailsViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class HNScrollListCell, HNAvatarView, HNBorderButton;
@interface HNTeamDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    UILabel* nameLabel;
    HNAvatarView* imageView;
    
    UILabel* twitterVal;
    
    HNBorderButton* copyEmailButton;
    HNBorderButton* sendEmailButton;
    
    
    UITextView* rolesVal;
    
    
    MFMailComposeViewController* mailController;
}




@property (nonatomic, strong) HNScrollListCell* cell;



- (id)initWithCell: (HNScrollListCell*)cell;

@end
