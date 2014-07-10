//
//  HNNotificationTableViewCell.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/9/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNNotificationTableViewCell : UITableViewCell
{
    UIImageView* avatarView;
    
    UILabel*     nameLabel;
    UILabel*     timeLabel;
    UITextView*  messageView;
    
    
}


@property (nonatomic, strong) UIImage* avatarImage;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* message;





@end
