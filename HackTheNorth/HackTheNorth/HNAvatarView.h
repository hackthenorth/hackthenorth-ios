//
//  HNAvatarView.h
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNAvatarView : UIImageView
{
    
    UILabel*  _letterLabel;
}


@property (nonatomic, strong) NSString* letter;


- (instancetype)initWithFrame:(CGRect)frame letter: (NSString*)letter;




@end
