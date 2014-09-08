//
//  HNMapViewController.h
//  HackTheNorth
//
//  Created by Si Te Feng on 9/8/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@class HNPanImageView;
@interface HNCampusMapViewController : UIViewController <MKMapViewDelegate>
{
    UISegmentedControl* mapTypeControl;
    UIWebView* webView;
    
    MKMapView* mapView;
}









@end
