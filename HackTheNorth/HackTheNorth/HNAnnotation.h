//
//  HNAnnotation.h
//  HackTheNorth
//
//  Created by Si Te Feng on 9/8/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HNAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



- (instancetype)initWithLocation: (CLLocationCoordinate2D)coord title:(NSString*)title subtitle: (NSString*)subtitle;

@end
