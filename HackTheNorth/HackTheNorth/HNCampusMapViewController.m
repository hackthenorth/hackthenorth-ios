//
//  HNMapViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 9/8/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNCampusMapViewController.h"
#import "UserInterfaceConstants.h"
#import "HNPanImageView.h"
#import "HNAnnotation.h"
#import "JPStyle.h"

static NSString* const kMapViewAnnotation;


@interface HNCampusMapViewController ()

@end

@implementation HNCampusMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;

    mapTypeControl = [[UISegmentedControl alloc] initWithItems:@[@"Standard", @"Campus"]];
    [mapTypeControl addTarget:self action:@selector(mapTypeChanged) forControlEvents:UIControlEventValueChanged];
    [mapTypeControl setSelectedSegmentIndex:0];
    [mapTypeControl sizeToFit];
    self.navigationItem.titleView = mapTypeControl;

    
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"pdf"];
//    NSURL* mapURL = [NSURL URLWithString:imagePath];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = webView.frame;
        frame.size.height -= 88;
        webView.frame = frame;
    }
    [webView loadData:[NSData dataWithContentsOfFile:imagePath] MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
    webView.scrollView.minimumZoomScale = 1;
    webView.scrollView.maximumZoomScale = 6;
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    webView.hidden = NO;
    [self.view addSubview:webView];
    

    //MKMapView
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = mapView.frame;
        frame.size.height -= 88;
        mapView.frame = frame;
    }
    mapView.delegate = self;
    mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(43.47285803,-80.54014385);
    
    HNAnnotation* schoolAnnotation = [[HNAnnotation alloc] initWithLocation:coord title:@"Engineering 5" subtitle:@"University of Waterloo"];
    [mapView addAnnotation:schoolAnnotation];
    
    MKPlacemark* schoolPlacemark = [[MKPlacemark alloc] initWithCoordinate:coord addressDictionary:@{(NSString*)kABPersonAddressStreetKey:@"200 University Ave W", (NSString*)kABPersonAddressCityKey:@"Waterloo", (NSString*)kABPersonAddressCountryCodeKey:@"Canada", (NSString*)kABPersonAddressStateKey:@"ON", (NSString*)kABPersonAddressZIPKey:@"N2L 3G1"}];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[MKMapItem mapItemForCurrentLocation]];
    [request setDestination:[[MKMapItem alloc] initWithPlacemark:schoolPlacemark]];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    [request setRequestsAlternateRoutes:YES];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            for (MKRoute *route in [response routes]) {
                [mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
                
            }
        }
    }];
    
    [self.view addSubview:mapView];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(43.47285803,-80.54014385);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1500, 1500);
    [mapView setRegion:region animated:YES];
    
    for(id<MKAnnotation> annotation in mapView.annotations)
        [mapView selectAnnotation:annotation animated:YES];
}



- (void)mapTypeChanged
{
    NSInteger mapType = mapTypeControl.selectedSegmentIndex;
    
    if(mapType == 0) //standard
    {
        webView.hidden = YES;
        mapView.hidden = NO;
    }
    else
    {
        webView.hidden = NO;
        mapView.hidden = YES;
    }
    
}


#pragma mark - MKMapView Delegate




- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
