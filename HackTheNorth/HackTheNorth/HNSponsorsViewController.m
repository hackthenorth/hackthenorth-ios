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
    
    self.webView.delegate = self;
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://i.imgur.com/VLyNA7m.png"]];
    [self.webView loadRequest:request];
    
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
