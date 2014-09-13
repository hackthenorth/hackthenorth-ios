//
//  HNSponsorsViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 9/8/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNSponsorsViewController.h"
#import "UserInterfaceConstants.h"
#import "SVStatusHUD.h"
#import "DejalActivityView.h"
#import "JPStyle.h"
#import "AFNetworking.h"

@interface HNSponsorsViewController ()

@end

@implementation HNSponsorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"Sponsors";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = self.webView.frame;
        frame.size.height -= 88;
        self.webView.frame = frame;
    }

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"https://hackthenorth.firebaseio.com/mobile/sponsors.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* imageLink = (NSString*)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageLink]];
        [self.webView loadRequest:request];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Failure: %@", error.localizedDescription);
    }];
    
    self.webView.delegate = self;
    
    
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVStatusHUD showWithImage:[UIImage imageNamed:@"noWifi"] status:@"Connection Error"];
    [DejalBezelActivityView removeViewAnimated:YES];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:100];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [DejalBezelActivityView removeViewAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
