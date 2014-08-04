//
//  HNScrollListItem.h
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNScrollListItem : UIView
{
    NSString* _displayText;
    
    UILabel*  textLabel;
}



@property (nonatomic, strong) NSString* text;



+ (CGFloat)widthWithString:(NSString*)string;


@end
