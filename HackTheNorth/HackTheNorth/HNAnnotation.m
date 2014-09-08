//
//  HNAnnotation.m
//  HackTheNorth
//
//  Created by Si Te Feng on 9/8/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNAnnotation.h"

@implementation HNAnnotation

- (instancetype)initWithLocation: (CLLocationCoordinate2D)coord title:(NSString*)title subtitle: (NSString*)subtitle
{
    self = [super init];
    _coordinate = coord;
    _title = title;
    _subtitle = subtitle;
    
    return self;
}







@end
