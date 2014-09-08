//
//  HNAvatarView.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsyncImageView;
@interface HNAvatarView : UIImageView
{
    UILabel*  _letterLabel;
    UIImageView* _asyncImageView;
    
    UIImageView* backgroundView;
}

@property (nonatomic, assign) BOOL shouldHideLogo;

@property (nonatomic, strong) NSString* letter;
@property (nonatomic, strong) UIColor* letterBackColor;

@property (nonatomic, strong) NSURL* imageUrl;


- (instancetype)initWithFrame:(CGRect)frame letter: (NSString*)letter;

- (instancetype)initWithFrame:(CGRect)frame imageURL: (NSURL*)url;





@end
