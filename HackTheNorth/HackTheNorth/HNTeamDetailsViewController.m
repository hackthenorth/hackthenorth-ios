//
//  HNTeamDetailsViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 2014-08-17.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNTeamDetailsViewController.h"
#import "HNScrollListCell.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UserInterfaceConstants.h"
#import "UIColor+RGBValues.h"
#import "HNAvatarView.h"
#import "NSDate+HNConvenience.h"
#import "SVStatusHUD.h"
#import "HNBorderButton.h"
#import "SVStatusHUD.h"
#import "NSString+HNConvenience.h"


@interface HNTeamDetailsViewController ()

@end

@implementation HNTeamDetailsViewController

- (id)initWithCell: (HNScrollListCell*)cell
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = cell.backgroundColor;
        
        self.cell = cell;
        
        self.title = @"Volunteer Details";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 10, kiPhoneWidthPortrait-10, 40)];
    nameLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:35];
    nameLabel.textColor = [[JPStyle interfaceTintColor] darkerColor];
    [self.view addSubview:nameLabel];
    
    
    imageView = [[HNAvatarView alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 65, 100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UIView* shadowView = [[UIView alloc] initWithFrame:imageView.frame];
    shadowView.backgroundColor = [UIColor whiteColor];
    //    shadowView.layer.cornerRadius = imageView.layer.cornerRadius;
    //    shadowView.layer.shadowOffset = CGSizeMake(4, 8);
    //    shadowView.layer.shadowOpacity = 0.5;
    //    shadowView.layer.shadowRadius = 5;
    [self.view insertSubview:shadowView belowSubview:imageView];
    
    UILabel* twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 60, kiPhoneWidthPortrait-130, 25)];
    twitterLabel.text = @"Twitter";
    twitterLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:twitterLabel];
    
    twitterVal = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 85, kiPhoneWidthPortrait-130, 20)];
    twitterVal.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    twitterVal.textColor = [UIColor darkGrayColor];
    [self.view addSubview:twitterVal];
    
    UILabel* avaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 115, kiPhoneWidthPortrait-130, 25)];
    avaiLabel.text = @"Email";
    avaiLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:avaiLabel];
    
    copyEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 92, 50)];
    [copyEmailButton addTarget:self action:@selector(copyEmail) forControlEvents:UIControlEventTouchUpInside];
    [copyEmailButton setTitle:@"Copy Email" forState:UIControlStateNormal];
    [self.view addSubview:copyEmailButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125 + 95, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 92, 50)];
    [sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendEmailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendEmailButton];
    
    /////////////////////////////////////////////////////
    
    UIView* skillBackground = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 210, kiPhoneWidthPortrait, kiPhoneHeightPortrait - 275)];
    skillBackground.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:skillBackground];
    
    UILabel* rolesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 220, kiPhoneWidthPortrait-20, 30)];
    rolesLabel.text = @"Roles";
    rolesLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    rolesLabel.textColor = [UIColor blackColor];
    [self.view addSubview:rolesLabel];
    
    
    rolesVal = [[UITextView alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 250, kiPhoneWidthPortrait-20, 200)];
    rolesVal.backgroundColor = [UIColor clearColor];
    rolesVal.editable = NO;
    rolesVal.selectable = NO;
    rolesVal.textColor = [[JPStyle interfaceTintColor] darkerColor];
    rolesVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    rolesVal.textContainer.lineFragmentPadding = 0;
    rolesVal.textContainerInset = UIEdgeInsetsZero;
    [self.view addSubview:rolesVal];
    
    
}


- (void)sendEmail
{
    if(![MFMailComposeViewController canSendMail])
    {
        [[[UIAlertView alloc] initWithTitle:@"Can't Send Email" message:@"Please setup your email account first in the Settings app" delegate:nil cancelButtonTitle:@"I See" otherButtonTitles: nil] show];
        return;
    }
    
    HNScrollListCell* cell = self.cell;
    
    mailController = [[MFMailComposeViewController alloc] init];
    [mailController setSubject:@"HackTheNorth: "];
    mailController.mailComposeDelegate = self;
    
    if(cell.email)
    {
        [mailController setToRecipients:@[cell.email]];
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"cantSendEmailHUD.png"] status:@"No Email Info"];
        return;
    }
    
    [self presentViewController:mailController animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)copyEmail
{
    UIPasteboard* paste = [UIPasteboard generalPasteboard];
    
    if(self.cell.email)
    {
        [paste setString:self.cell.email];
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"copiedHUD"] status:@"Copied"];
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"cantSendEmailHUD.png"] status:@"No Email Info"];
        return;
    }
    
}



- (void)setCell:(HNScrollListCell *)cell
{
    _cell = cell;
    
    nameLabel.text = self.cell.title;
    twitterVal.text = self.cell.subtitle;
    
    imageView.imageUrl = self.cell.imageURL;
    
    
    NSMutableString* skillText = [@"" mutableCopy];
    
    for(NSString* skill in self.cell.detailList)
    {
        [skillText appendString:[NSString stringWithFormat:@"%@, ", [skill cappedString]]];
    }
    
    if(skillText.length>=2)
        rolesVal.text = [skillText substringToIndex:skillText.length-2];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
