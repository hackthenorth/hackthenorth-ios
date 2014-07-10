//
//  iPadBannerView.h
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNBannerView : UIScrollView <UIScrollViewDelegate>
{
    @private
    
    float          _bannerWidth;
    BOOL           _bannerRightIsSet;
    BOOL           _bannerLeftIsSet;
    
    NSTimer*       _scrollTimer;
    CGRect         _frame;
    
    BOOL           _isReachable;
    
}


//Array of UIImageNames
@property (nonatomic, strong) NSMutableArray* imgNameArray;



//Array of UIImageView
@property (nonatomic, strong) NSMutableArray* bannerArray;



- (void)pauseAutoscroll;

- (void)activateAutoscroll; //Autoscroll by Default



@end
