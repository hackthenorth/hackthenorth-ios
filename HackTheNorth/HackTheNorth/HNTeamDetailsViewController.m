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
    
    ///////////////////////
    UILabel* twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 60, kiPhoneWidthPortrait-20, 25)];
    twitterLabel.text = @"Twitter";
    twitterLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:twitterLabel];
    
    twitterVal = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 85, kiPhoneWidthPortrait-130, 20)];
    twitterVal.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    twitterVal.textColor = [UIColor darkGrayColor];
    [self.view addSubview:twitterVal];
    
    UILabel* contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 115, kiPhoneWidthPortrait-130, 25)];
    contactLabel.text = @"Contact";
    contactLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:contactLabel];
    
    phoneButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 90, 44)];
    [phoneButton addTarget:self action:@selector(startPhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"Phone" forState:UIControlStateNormal];
    [self.view addSubview:phoneButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10 + 110, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 90, 44)];
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
    
    
    rolesVal = [[UITextView alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 250, kiPhoneWidthPortrait-30, 200)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = rolesVal.frame;
        frame.size.height -= 88;
        rolesVal.frame = frame;
    }
    rolesVal.showsVerticalScrollIndicator = NO;
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


- (void)startPhoneCall
{
    if(self.cell.phone)
    {
        UIPasteboard* paste = [UIPasteboard generalPasteboard];
        [paste setString:[NSString stringWithFormat:@"%@", self.cell.phone]];
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"copiedHUD"] status:@"Copied"];
        
        if([JPStyle isPhone])
        {
            NSString* phonePath = [NSString stringWithFormat:@"tel://%@", self.cell.phone];
            NSURL* phoneURL = [NSURL URLWithString:phonePath];
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"questionHUD.png"] status:@"No Phone Info"];
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
    
    //email button
    if(!cell.email ||[cell.email isEqualToString:@""])
    {
        sendEmailButton.backgroundColor = [JPStyle colorWithHex:@"e6e6e6" alpha:1];
    }
    else
    {
        sendEmailButton.backgroundColor = [UIColor clearColor];
    }
    
    //phone button
    if(!cell.phone)
    {
        phoneButton.backgroundColor = [JPStyle colorWithHex:@"e6e6e6" alpha:1];
    } else {
        phoneButton.backgroundColor = [UIColor clearColor];
    }
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
