//
//  iPadDashletTitleView.m
//  JumpPad
//
//  Created by Si Te Feng on 12/10/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "HNAutoresizingLabel.h"
#import "JPFont.h"

@implementation HNAutoresizingLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:NO];

        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    self.text = _text;
}

- (void) setText:(NSString *)text
{
    _text = text;
    self.titleLabel.text = text;
    
    CGFloat fontSize = 15.0;
    NSString* fontName = [JPFont defaultMediumFont];
    
    if(self.font)
    {
        fontName = self.font.fontName;
        fontSize = self.font.pointSize;
    }
    
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    
    while(size.width > self.titleLabel.bounds.size.width)
    {
        fontSize -= 0.5;
        
        size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]}];
    }
    
    self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    
}



- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
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
