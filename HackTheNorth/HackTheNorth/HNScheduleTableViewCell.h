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

}



@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, strong) NSString* speaker;
@property (nonatomic, strong) NSString* descriptor;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* endTime;

@end

