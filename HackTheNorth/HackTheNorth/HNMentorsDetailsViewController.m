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
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait)];
    [self.view addSubview:mainScrollView];

    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kiPhoneWidthPortrait-10, 40)];
    nameLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:35];
    nameLabel.textColor = [[JPStyle interfaceTintColor] darkerColor];
    [mainScrollView addSubview:nameLabel];
    
    UILabel* orgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, kiPhoneWidthPortrait-130, 25)];
    orgLabel.text = @"Organization";
    orgLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:orgLabel];

    org = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, kiPhoneWidthPortrait-20, 20)];
    org.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    org.textColor = [UIColor darkGrayColor];
    [mainScrollView addSubview:org];

    //Github
    UILabel* gitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, kiPhoneWidthPortrait-130, 25)];
    gitLabel.text = @"Github";
    gitLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:gitLabel];
    
    git = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, kiPhoneWidthPortrait-20, 25)];
    git.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    git.textColor = [UIColor darkGrayColor];
    [mainScrollView addSubview:git];
    
    //Function Buttons
    UILabel* contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, kiPhoneWidthPortrait-130, 25)];
    contactLabel.text = @"Contact";
    contactLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:contactLabel];
    
    phoneButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10, 200, 90, 44)];
    [phoneButton addTarget:self action:@selector(startPhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"Phone" forState:UIControlStateNormal];
    [mainScrollView addSubview:phoneButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10 + 110, 200, 90, 44)];
    [sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendEmailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:sendEmailButton];
    
    
    /////////////////////////////////////////////////////
    
    skillBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 250, kiPhoneWidthPortrait, 2000)];
    skillBackground.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [mainScrollView addSubview:skillBackground];
    
    
    UILabel* avaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, kiPhoneWidthPortrait-20, 30)];
    avaiLabel.text = @"Availability";
    avaiLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:avaiLabel];
    
    avai = [[UITextView alloc] initWithFrame:CGRectMake(125, 260, kiPhoneWidthPortrait-130, 105)];
    avai.backgroundColor = [UIColor clearColor];
    avai.editable = NO;
    avai.selectable = NO;
    avai.textContainer.lineFragmentPadding = 0;
    avai.showsVerticalScrollIndicator = NO;
    avai.textContainerInset = UIEdgeInsetsZero;
    avai.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    avai.textColor = [UIColor darkGrayColor];
    [mainScrollView addSubview:avai];


    UILabel* skillLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 350, kiPhoneWidthPortrait-30, 30)];
    skillLabel.text = @"Skills";
    skillLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    skillLabel.textColor = [UIColor blackColor];
    [mainScrollView addSubview:skillLabel];
    
    skillVal = [[UITextView alloc] initWithFrame:CGRectMake(20, 380, kiPhoneWidthPortrait-20, 100)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = skillVal.frame;
        frame.size.height -= 88;
        skillVal.frame = frame;
    }
    skillVal.showsVerticalScrollIndicator = NO;
    skillVal.backgroundColor = [UIColor clearColor];
    skillVal.editable = NO;
    skillVal.selectable = NO;
    skillVal.textColor = [[JPStyle interfaceTintColor] darkerColor];
    skillVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    skillVal.textContainer.lineFragmentPadding = 0;
    skillVal.textContainerInset = UIEdgeInsetsZero;
    [skillVal setUserInteractionEnabled:NO];
    [mainScrollView addSubview:skillVal];
    

}


- (void)setCell:(HNScrollListCell *)cell
{
    _cell = cell;
    
    nameLabel.text = self.cell.title;
    org.text = self.cell.subtitle;
    imageView.imageUrl = self.cell.imageURL;
    git.text = cell.github;
    
    UIColor* orgColor = [JPStyle colorWithCompanyName:org.text];
    skillBackground.backgroundColor = [orgColor colorWithAlphaComponent:0.2];
    
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
    
    [skillVal sizeToFit];
    
    CGRect skillValRect = skillVal.frame;
    
    [mainScrollView setContentSize:CGSizeMake(kiPhoneWidthPortrait, CGRectGetMaxY(skillValRect)+ 30)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = mainScrollView.frame;
        frame.size.height -= 88;
        mainScrollView.frame = frame;
    }
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
