//
//  HNBorderButton.m
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNBorderButton.h"
#import "JPFont.h"
#import "JPStyle.h"

@implementation HNBorderButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    self.layer.borderColor = [JPStyle interfaceTintColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 10;
    self.titleLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[JPStyle interfaceTintColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [self addTarget:self action:@selector(changeBorderColorWhite) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(changeBorderColorWhite) forControlEvents:UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(changeBorderColorBack) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(changeBorderColorBack) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}




- (void)longPressed: (UILongPressGestureRecognizer*)rec
{
    if(rec.state == UIGestureRecognizerStateBegan || rec.state == UIGestureRecognizerStateChanged)
    {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    else if(rec.state == UIGestureRecognizerStateCancelled || rec.state == UIGestureRecognizerStateFailed || rec.state == UIGestureRecognizerStateEnded)
    {
        self.layer.borderColor = [JPStyle interfaceTintColor].CGColor;
    }
    
}


- (void)changeBorderColorWhite
{
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)changeBorderColorBack
{
    self.layer.borderColor = [JPStyle interfaceTintColor].CGColor;
}





@end
