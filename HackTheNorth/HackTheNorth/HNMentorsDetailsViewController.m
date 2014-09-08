//
//  HNMentorsDetailsViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNMentorsDetailsViewController.h"
#import "HNScrollListCell.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UserInterfaceConstants.h"
#import "UIColor+RGBValues.h"
#import "HNAvatarView.h"
#import "NSDate+HNConvenience.h"
#import "NSString+HNConvenience.h"
#import "HNBorderButton.h"
#import "SVStatusHUD.h"

@interface HNMentorsDetailsViewController ()

@end

@implementation HNMentorsDetailsViewController

- (id)initWithCell: (HNScrollListCell*)cell
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = cell.backgroundColor;
        
        self.cell = cell;
        
        self.title = @"Mentor Details";
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
    [self.view insertSubview:shadowView belowSubview:imageView];
    
    UILabel* orgLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 60, kiPhoneWidthPortrait-130, 25)];
    orgLabel.text = @"Organization";
    orgLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:orgLabel];

    org = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 85, kiPhoneWidthPortrait-130, 20)];
    org.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    org.textColor = [UIColor darkGrayColor];
    [self.view addSubview:org];

    //Github
    
    UILabel* gitLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 165, kiPhoneWidthPortrait-10, 23)];
    gitLabel.text = @"Github";
    gitLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:gitLabel];
    
    git = [[UILabel alloc] initWithFrame:CGRectMake(5, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 185, 130, 20)];
    git.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    git.textColor = [UIColor darkGrayColor];
    [self.view addSubview:git];
    
    //Function Buttons
    UILabel* contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 115, kiPhoneWidthPortrait-130, 25)];
    contactLabel.text = @"Contact";
    contactLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:contactLabel];
    
    phoneButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 92, 44)];
    [phoneButton addTarget:self action:@selector(startPhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"Phone" forState:UIControlStateNormal];
    [self.view addSubview:phoneButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125 + 95, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 92, 44)];
    [sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendEmailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendEmailButton];
    
    
    /////////////////////////////////////////////////////
    
    UIView* skillBackground = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 210, kiPhoneWidthPortrait, kiPhoneHeightPortrait - 275)];
    skillBackground.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:skillBackground];
    
    
    UILabel* avaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 220, kiPhoneWidthPortrait-20, 30)];
    avaiLabel.text = @"Availability";
    avaiLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:avaiLabel];
    
    avai = [[UITextView alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 225, kiPhoneWidthPortrait-130, 105)];
    avai.backgroundColor = [UIColor clearColor];
    avai.editable = NO;
    avai.selectable = NO;
    avai.textContainer.lineFragmentPadding = 0;
    avai.showsVerticalScrollIndicator = NO;
    avai.textContainerInset = UIEdgeInsetsZero;
    avai.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    avai.textColor = [UIColor darkGrayColor];
    [self.view addSubview:avai];


    UILabel* skillLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 320, kiPhoneWidthPortrait-20, 30)];
    skillLabel.text = @"Skills";
    skillLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    skillLabel.textColor = [UIColor blackColor];
    [self.view addSubview:skillLabel];
    
    
    skillVal = [[UITextView alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 350, kiPhoneWidthPortrait-20, 100)];
    skillVal.showsVerticalScrollIndicator = NO;
    skillVal.backgroundColor = [UIColor clearColor];
    skillVal.editable = NO;
    skillVal.selectable = NO;
    skillVal.textColor = [[JPStyle interfaceTintColor] darkerColor];
    skillVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    skillVal.textContainer.lineFragmentPadding = 0;
    skillVal.textContainerInset = UIEdgeInsetsZero;
    [self.view addSubview:skillVal];
    

}


- (void)setCell:(HNScrollListCell *)cell
{
    _cell = cell;
    
    nameLabel.text = self.cell.title;
    org.text = self.cell.subtitle;
    
    imageView.imageUrl = self.cell.imageURL;
    
    git.text = cell.github;
    
    
    //////////////////////////////////
    NSMutableString* totalText = [@"" mutableCopy];
    for(NSArray* avaiTimes in self.cell.availability)
    {
        NSDate* startTime = [NSDate dateWithISO8601CompatibleString:[avaiTimes firstObject]];
        NSDate* endTime = [NSDate dateWithISO8601CompatibleString:[avaiTimes lastObject]];
        
        NSString* timesString = [NSString stringWithFormat: @"%@, %@-%@", [startTime dateStringForTableCell], [startTime timeStringForTableCell], [endTime timeStringForTableCell]];
        [totalText appendString: [NSString stringWithFormat:@"%@\n", timesString]];
    }
    
    avai.text = totalText;
    
    
    NSMutableString* skillText = [@"" mutableCopy];
    
    for(NSString* skill in self.cell.detailList)
    {
        [skillText appendString:[NSString stringWithFormat:@"%@, ", [skill cappedString]]];
    }
    
    if(skillText.length>=2)
        skillVal.text = [skillText substringToIndex:skillText.length-2];
    
    
    

}


#pragma mark - Function Button Callbacks

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
        if([JPStyle isPhone])
        {
            NSString* phonePath = [NSString stringWithFormat:@"tel://%@", self.cell.phone];
            NSURL* phoneURL = [NSURL URLWithString:phonePath];
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
        else
        {
            UIPasteboard* paste = [UIPasteboard generalPasteboard];
            [paste setString:[NSString stringWithFormat:@"%@", self.cell.phone]];
            [SVStatusHUD showWithImage:[UIImage imageNamed:@"copiedHUD"] status:@"Copied"];
        }

    }
    else
    {
        [SVStatusHUD showWithImage:[UIImage imageNamed:@"cantSendEmailHUD.png"] status:@"No Email Info"];
        return;
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
