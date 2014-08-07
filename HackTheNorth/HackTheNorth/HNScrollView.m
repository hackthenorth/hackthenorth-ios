//
//  HNScrollView.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/4/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScrollView.h"

@implementation HNScrollView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    for(UIGestureRecognizer* rec in self.gestureRecognizers)
    {
        rec.delegate = self;
        _nextResponderTouchEnded = YES;
        
    }
    
    
    return self;
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!self.dragging)
    {
        [self.nextResponder touchesBegan:touches withEvent:event];
        _nextResponderTouchEnded = NO;
    }
    else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_nextResponderTouchEnded)
    {
        [self.nextResponder touchesCancelled:touches withEvent:event];
        _nextResponderTouchEnded = YES;
    }
    
    [super touchesMoved:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(!_nextResponderTouchEnded)
    {
        [self.nextResponder touchesCancelled:touches withEvent:event];
        _nextResponderTouchEnded = YES;
    }
    
    [super touchesCancelled:touches withEvent:event];
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!self.dragging)
    {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
    else {
        [super touchesEnded:touches withEvent:event];
    }
}





@end
