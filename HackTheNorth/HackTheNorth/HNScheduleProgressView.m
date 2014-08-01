//
//  HNScheduleProgressView.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScheduleProgressView.h"
#import "LDProgressView.h"
#import "UserInterfaceConstants.h"
#import "JPStyle.h"
#import "UIColor+RGBValues.h"
#import "JPFont.h"


@implementation HNScheduleProgressView


- (instancetype)initWithFrame:(CGRect)frame startDate:(NSDate *)start endDate:(NSDate *)end
{
    self = [super initWithFrame:frame];
    
    self.startDate = start;
    self.endDate = end;
    
    _progressBarStyleIsSet = NO;
    
    self.progressBar = [[LDProgressView alloc] initWithFrame:CGRectMake(10, 35, kiPhoneWidthPortrait - 20, 25)];
    self.progressBar.color = [JPStyle colorWithName:@"blue"];
    self.progressBar.flat = @YES;
    self.progressBar.showText = @YES;
    [self.progressBar overrideProgressTextColor:[UIColor whiteColor]];
    self.progressBar.background = [UIColor lightGrayColor];
    self.progressBar.animate = @YES;
    self.progressBar.type = LDProgressStripes;
    [self addSubview:self.progressBar];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, kiPhoneWidthPortrait - 20, 35)];
    timeLabel.font = [JPFont coolFontOfSize:23];
    timeLabel.text = @"00:00:00";
    [self addSubview:timeLabel];
    
    timeLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kiPhoneWidthPortrait - 20, 35)];
    timeLeftLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:23];
    
    timeLeftLabel.textAlignment = NSTextAlignmentRight;
    timeLeftLabel.textColor = [JPStyle colorWithName:@"darkGreen"];
    [self addSubview:timeLeftLabel];
    
    CGRect dayRect = CGRectMake(10, 60, kiPhoneWidthPortrait-20, 25);

    UILabel* l1 = [[UILabel alloc] initWithFrame:dayRect];
    l1.text = @"FRIDAY";
    l1.textColor = [UIColor grayColor];
    l1.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
    l1.textAlignment = NSTextAlignmentLeft;
    [self addSubview:l1];
    UILabel* l2 = [[UILabel alloc] initWithFrame:dayRect];
    l2.text = @"SATURDAY";
    l2.textColor = [UIColor grayColor];
    l2.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
    l2.textAlignment = NSTextAlignmentCenter    ;
    [self addSubview:l2];
    UILabel* l3 = [[UILabel alloc] initWithFrame:dayRect];
    l3.text = @"SUNDAY";
    l3.textColor = [UIColor grayColor];
    l3.font = [UIFont fontWithName:[JPFont defaultFont] size:16];
    l3.textAlignment = NSTextAlignmentRight;
    [self addSubview:l3];
    
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [_updateTimer fire];
    
    return self;
}


- (void)updateProgress
{
    NSDate* now = [NSDate date];
    
    NSTimeInterval totalInterval = [self.endDate timeIntervalSinceDate:self.startDate];
    NSTimeInterval currentInterval = [now timeIntervalSinceDate:self.startDate];
    NSTimeInterval timeLeftInterval = [self.endDate timeIntervalSinceNow];
    CGFloat percentageComplete = (CGFloat)currentInterval/totalInterval;
    
    
    //Progress Bar
    self.progressBar.progress = percentageComplete;
    
    if(!_progressBarStyleIsSet && percentageComplete < 1 && percentageComplete > 0)
    {
        self.progressBar.animate = @YES;
        self.progressBar.type = LDProgressStripes;
        _progressBarStyleIsSet = YES;
    }
    
    if(percentageComplete >= 1)
    {
        self.progressBar.animate = @NO;
        self.progressBar.type = LDProgressSolid;
        [_updateTimer invalidate];
        self.progressBar.progress = 1.0f;
    }
    
    //Top Labels
    //left
    double currSeconds = fmod(currentInterval, 60);
    
    double currMinutes = fmod(currentInterval/60, 60);
    
    double currHours = currentInterval/ 3600;
    
    NSString* currSecondsStr = [NSString stringWithFormat:@"%.00f", currSeconds];
    if(currSeconds< 9.5)
    {
        currSecondsStr = [NSString stringWithFormat:@"0%.00f", currSeconds];
    }
    
    NSString* currMinutesStr = [NSString stringWithFormat:@"%.00f", currMinutes];
    if(currMinutes< 9.5)
    {
        currMinutesStr = [NSString stringWithFormat:@"0%.00f", currMinutes];
    }

    NSString* currHoursStr = [NSString stringWithFormat:@"%.00f", currHours];
    if(currHours< 9.5)
    {
        currHoursStr = [NSString stringWithFormat:@"0%.00f", currHours];
    }
    
    if(currentInterval >= 0) {
        timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", currHoursStr, currMinutesStr, currSecondsStr];
    }
    
    
    //right
    double leftSeconds = fmod(timeLeftInterval, 60);
    double leftMinutes = fmod(timeLeftInterval/60, 60);
    double leftHours   = timeLeftInterval/ 3600;
    
    if(leftHours >= 1)
    {
        if(leftHours > totalInterval/3600)
        {
            NSTimeInterval nowToStart = [self.startDate timeIntervalSinceNow];
            double leftDays  = nowToStart/ 3600*24;
            NSString* leftDaysStr = [NSString stringWithFormat:@"%.00f", leftDays];
            if([leftDaysStr isEqual:@"1"])
            {
                timeLeftLabel.text = @"1 More Day!";
            } else if([leftDaysStr isEqual:@"0"]) {
                timeLeftLabel.text = @"Starting Soon...";
            } else {
                timeLeftLabel.text = [NSString stringWithFormat:@"%.00f days to go", leftDays];
            }
            
            timeLeftLabel.textColor = [UIColor grayColor];
        }
        else {
            timeLeftLabel.text = [NSString stringWithFormat:@"%.00f Hrs Left", leftHours];
            timeLeftLabel.textColor = [JPStyle colorWithName:@"darkGreen"];
        }
    }
    else if(leftMinutes >= 1)
    {
        timeLeftLabel.text = [NSString stringWithFormat:@"%.00f Mins Left", leftMinutes];
        timeLeftLabel.textColor = [[UIColor orangeColor] darkerColor];
        if(leftMinutes<20)
        {
            timeLeftLabel.textColor = [[UIColor redColor] darkerColor];
        }
    }
    else if(leftSeconds >= 0.5)
    {
        timeLeftLabel.text = [NSString stringWithFormat:@"%.00f Secs Left", leftSeconds];
        timeLeftLabel.textColor = [UIColor redColor];
    }
    else {
        timeLeftLabel.text = @"Completed!";
        timeLeftLabel.textColor = [UIColor grayColor];
    }
    
    
    
}





















@end
