//
//  HNScrollListItem.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScrollListItem.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UIColor+RGBValues.h"


@implementation HNScrollListItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 2;
    self.layer.cornerRadius = frame.size.height/2.0;
    self.clipsToBounds = YES;
    
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    textLabel.font = [self.class defaultFont];
    textLabel.text = @"";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    
    return self;
}







- (void)setText:(NSString *)text
{
    _text = text;
    _displayText = [NSString stringWithFormat:@" %@ ", text];
    
    UIColor* color = [JPStyle colorWithLetter:text];
    
    textLabel.text = _displayText;
    textLabel.textColor = color;
    
    self.layer.borderColor = color.CGColor;
    self.backgroundColor = [color colorWithAlphaComponent:0];
    
}




+ (CGFloat)widthWithString:(NSString *)string
{
    NSString* displayString = [NSString stringWithFormat:@" %@ ", string];
    
    CGSize stringSize = [displayString sizeWithAttributes:@{NSFontAttributeName: [self defaultFont]}];
    
    return stringSize.width + 10;
}




+ (UIFont*)defaultFont
{
    return [UIFont fontWithName:[JPFont defaultFont] size:20];
}








@end
