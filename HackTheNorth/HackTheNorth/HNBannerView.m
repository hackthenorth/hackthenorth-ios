//
//  iPadBannerView.m
//  JumpPad
//
//  Created by Si Te Feng on 2/23/2014.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNBannerView.h"


@implementation HNBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackground"]];
        
        _frame = frame;
        
        //Setting up iVars
        _bannerRightIsSet = NO; //this flag prevents scroll being stalled
        _bannerLeftIsSet = NO;
        
        _bannerWidth = frame.size.width;

        self.bannerArray = [NSMutableArray array];

        //Setting up properties for Scroll View
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentInset = UIEdgeInsetsZero;
        self.pagingEnabled = YES;
        
        self.delegate = self;
        
        //Show 2nd Banner first for infinite scrolling
        [self setContentOffset:CGPointMake(_bannerWidth, 0) animated:NO];
        
        //Setting up Automatic Scrolling
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(autoscrollBanner) userInfo:nil repeats:YES];

        
    }
    return self;
}



- (void)setImgNameArray:(NSMutableArray *)imgNameArray
{
    _imgNameArray = imgNameArray;
    
    CGRect frame = _frame;
    
    
    if([_imgNameArray count]==0)
    {
        UIImage* defaultImage = [UIImage imageNamed:@"hackTheNorthBanner2"];
    
        UIImageView* imgView = [[UIImageView alloc] initWithImage:defaultImage];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self.bannerArray addObject:imgView];
        [self setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        
        [self addSubview: [self.bannerArray firstObject]];
    }
    else if([_imgNameArray count]==1)
    {
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.image = [UIImage imageNamed:[_imgNameArray firstObject]];
        
        [self.bannerArray addObject:imgView];
        [self setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        [self addSubview: [self.bannerArray firstObject]];
    }
    else
    {
        self.bannerArray = [NSMutableArray array];
        
        //Adding all the banners to the view
        for(int i=0; i< [_imgNameArray count]; i++)
        {
            UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            imgView.image = [UIImage imageNamed:_imgNameArray[i]];
            
            [self.bannerArray addObject:imgView];
            [self addSubview: self.bannerArray[i]];
        }
        
        //Adding a repeated 1st and 2nd images of the array for Infinite Scrolling
        for(int i=0; i< 2; i++)
        {
            UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake((i+[_imgNameArray count])*frame.size.width, 0, frame.size.width, frame.size.height)];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            imgView.image = [UIImage imageNamed:_imgNameArray[i]];
            
            [self.bannerArray addObject:imgView];
            [self addSubview: self.bannerArray[i+[_imgNameArray count]]];
            
        }
        
        [self setContentSize:CGSizeMake(frame.size.width*([_imgNameArray count]+2), frame.size.height)];
        
    }
    
}



//Auto Scrolling the banner periodically
- (void)autoscrollBanner
{
    float currentOffset = self.contentOffset.x;
    
    CGPoint newOffset = CGPointMake(currentOffset + _bannerWidth, 0);
    [self setContentOffset:newOffset animated:YES];
}


#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger imageCount = [self.imgNameArray count];
    
    //Setting up Infinite Scrolling
    
    //Right Side
    BOOL isLastBanner = fabs(scrollView.contentOffset.x - _bannerWidth*(imageCount+1)) < 8.0;
    CGPoint secondBanner = CGPointMake(_bannerWidth, 0);
    
    if(isLastBanner && !_bannerRightIsSet)
    {
        [self setContentOffset:secondBanner animated:NO];
        _bannerRightIsSet = YES;
    }
    
    BOOL isOutsideRightDetectionZone = (fabs(scrollView.contentOffset.x - _bannerWidth*(imageCount+1)) > 8.0) && (fabs(scrollView.contentOffset.x - _bannerWidth*(imageCount+1)) < 100.0);

    if(isOutsideRightDetectionZone)
    {
        _bannerRightIsSet = NO;
    }
    
    //Left Side
    BOOL isFirstBanner = fabs(scrollView.contentOffset.x - 0) < 8.0;
    CGPoint firstBanner = CGPointMake(_bannerWidth*(imageCount), 0);
    
    if(isFirstBanner && !_bannerLeftIsSet)
    {
        [self setContentOffset:firstBanner animated:NO];
    }
    
    BOOL isOutSideLeftDetectionZone = (fabs(scrollView.contentOffset.x - 0) > 8.0) && (fabs(scrollView.contentOffset.x - 0) < 100.0);
    
    if(isOutSideLeftDetectionZone)
    {
        _bannerLeftIsSet = NO;
    }

}


- (void)pauseAutoscroll
{
    
    [_scrollTimer invalidate];
    _scrollTimer = nil;

}


- (void)activateAutoscroll
{
    if(!_scrollTimer)
    {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(autoscrollBanner) userInfo:nil repeats:YES];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
