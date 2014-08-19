//
//  HNPrizesDetailsViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/18/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class HNScrollListCell, HNAvatarView, HNBorderButton, HNAutoresizingLabel;
@interface HNPrizesDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    UIScrollView* mainScrollView;
    
    HNAutoresizingLabel* nameLabel;
    HNAvatarView* imageView;
    
    UILabel* twitterVal;
    
    HNBorderButton* copyEmailButton;
    HNBorderButton* sendEmailButton;
    
    UITextView* prizesVal;
    UILabel*    detailsLabel;
    UITextView* detailsVal;
    
    UIView*     _skillBackground;
    
    MFMailComposeViewController* mailController;
}




@property (nonatomic, strong) HNScrollListCell* cell;



- (id)initWithCell: (HNScrollListCell*)cell;


@end
