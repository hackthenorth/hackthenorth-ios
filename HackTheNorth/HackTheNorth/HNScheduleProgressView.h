//
//  HNScheduleProgressView.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDProgressView;
@interface HNScheduleProgressView : UIView
{
    BOOL   _progressBarStyleIsSet;
    
    NSTimer* _updateTimer;
    
    UILabel*  timeLabel;
    UILabel*  timeLeftLabel;
  
}


@property (nonatomic, strong) LDProgressView* progressBar;

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;



- (instancetype)initWithFrame:(CGRect)frame startDate: (NSDate*)start endDate: (NSDate*)end;



@end
