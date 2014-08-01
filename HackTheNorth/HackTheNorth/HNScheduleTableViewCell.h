//
//  NSScheduleTableViewCell.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNAvatarView;
@interface HNScheduleTableViewCell : UITableViewCell
{
    HNAvatarView* avatarView;
    
    UILabel*     nameLabel;
    UILabel*     timeLabel;
    UILabel*     locationLabel;
    
    UILabel*     speakerLabel;


}








@end
