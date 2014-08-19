//
//  HNPrizesDetailsViewController.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/18/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNPrizesDetailsViewController.h"
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
#import "HNAutoresizingLabel.h"


@interface HNPrizesDetailsViewController ()

@end

@implementation HNPrizesDetailsViewController

- (id)initWithCell: (HNScrollListCell*)cell
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = cell.backgroundColor;
        
        self.cell = cell;
        
        self.title = @"Prize Details";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kiPhoneWidthPortrait, kiPhoneHeightPortrait)];
    [self.view addSubview:mainScrollView];
    
    nameLabel = [[HNAutoresizingLabel alloc] initWithFrame:CGRectMake(10, 10, kiPhoneWidthPortrait-20, 40)];
    nameLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:35];
    nameLabel.titleLabel.textColor = [[JPStyle interfaceTintColor] darkerColor];
    [mainScrollView addSubview:nameLabel];
    
    
    imageView = [[HNAvatarView alloc] initWithFrame:CGRectMake(10,65, 100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [mainScrollView addSubview:imageView];
    
    UIView* shadowView = [[UIView alloc] initWithFrame:imageView.frame];
    shadowView.backgroundColor = [UIColor whiteColor];
    //    shadowView.layer.cornerRadius = imageView.layer.cornerRadius;
    //    shadowView.layer.shadowOffset = CGSizeMake(4, 8);
    //    shadowView.layer.shadowOpacity = 0.5;
    //    shadowView.layer.shadowRadius = 5;
    [mainScrollView insertSubview:shadowView belowSubview:imageView];
    
    UILabel* twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 60, kiPhoneWidthPortrait-130, 25)];
    twitterLabel.text = @"Company";
    twitterLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:twitterLabel];
    
    twitterVal = [[UILabel alloc] initWithFrame:CGRectMake(125, 85, kiPhoneWidthPortrait-130, 20)];
    twitterVal.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    twitterVal.textColor = [UIColor darkGrayColor];
    [mainScrollView addSubview:twitterVal];
    
    UILabel* avaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 115, kiPhoneWidthPortrait-130, 25)];
    avaiLabel.text = @"Email";
    avaiLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [mainScrollView addSubview:avaiLabel];
    
    copyEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125, 145, 92, 50)];
    [copyEmailButton addTarget:self action:@selector(copyEmail) forControlEvents:UIControlEventTouchUpInside];
    [copyEmailButton setTitle:@"Copy Email" forState:UIControlStateNormal];
    [mainScrollView addSubview:copyEmailButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(125 + 95, 145, 92, 50)];
    [sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendEmailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:sendEmailButton];
    
    /////////////////////////////////////////////////////
    
    UILabel* prizesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, kiPhoneWidthPortrait-20, 30)];
    prizesLabel.text = @"Prizes";
    prizesLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    prizesLabel.textColor = [UIColor blackColor];
    [mainScrollView addSubview:prizesLabel];
    
    prizesVal = [[UITextView alloc] initWithFrame:CGRectMake(15, 250, kiPhoneWidthPortrait-30, 100)];
    prizesVal.backgroundColor = [UIColor clearColor];
    prizesVal.editable = NO;
    prizesVal.selectable = NO;
    prizesVal.textColor = [[JPStyle interfaceTintColor] darkerColor];
    prizesVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    prizesVal.textContainer.lineFragmentPadding = 0;
    prizesVal.textContainerInset = UIEdgeInsetsZero;
    [mainScrollView addSubview:prizesVal];
    
    
    ///////////////
    
    detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, kiPhoneWidthPortrait-20, 30)];
    detailsLabel.text = @"Details";
    detailsLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    detailsLabel.textColor = [UIColor blackColor];
    [mainScrollView addSubview:detailsLabel];
    
    detailsVal = [[UITextView alloc] initWithFrame:CGRectMake(15, 400, kiPhoneWidthPortrait-30, 200)];
    detailsVal.backgroundColor = [UIColor clearColor];
    detailsVal.editable = NO;
    detailsVal.selectable = NO;
    detailsVal.textColor = [UIColor blackColor];
    detailsVal.font = [JPFont fontWithName:[JPFont defaultThinFont] size:17];
    detailsVal.textContainer.lineFragmentPadding = 0;
    detailsVal.textContainerInset = UIEdgeInsetsZero;
    [mainScrollView addSubview:detailsVal];
    
    mainScrollView.contentSize = CGSizeZero;
    _skillBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 210, kiPhoneWidthPortrait, mainScrollView.contentSize.height - 210 + 100)];
    _skillBackground.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [mainScrollView addSubview:_skillBackground];
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
    
    imageView.letter= self.cell.subtitle;
    imageView.letterBackColor = [JPStyle colorWithCompanyName:self.cell.subtitle];
    
    ////////////////////////
    //Prizes
    NSMutableString* prizesText = [@"" mutableCopy];
    prizesVal.text = @"";
    
    for(NSString* prize in self.cell.detailList)
    {
        [prizesText appendString:[NSString stringWithFormat:@"%@, ", [prize cappedString]]];
    }
    
    if(prizesText.length>=2)
    {
        prizesVal.text = [prizesText substringToIndex:prizesText.length-2];
    }

    CGSize prizeSize = [prizesVal sizeThatFits:prizesVal.frame.size];
    prizesVal.frame = CGRectMake(prizesVal.frame.origin.x, prizesVal.frame.origin.y, prizesVal.frame.size.width, prizeSize.height + 10);
    CGFloat currYPos = prizesVal.frame.origin.y + prizesVal.frame.size.height + 20;
    
    /////////////////////
    //Detail Label
    detailsLabel.frame = CGRectMake(detailsLabel.frame.origin.x, currYPos, detailsLabel.frame.size.width, detailsLabel.frame.size.height);
    currYPos += detailsLabel.frame.size.height + 5;

    /////////////////////
    //Detail Text
    NSString* detailText = @"";
    if(cell.descriptor && ![cell.descriptor isEqual:[NSNull null]])
    {
        detailText = cell.descriptor;
    }
    
    [detailsVal removeFromSuperview];
    detailsVal.text = detailText;
    [mainScrollView addSubview:detailsVal];
    
    CGSize detailsSize = [detailsVal sizeThatFits:detailsVal.frame.size];
    detailsVal.frame = CGRectMake(detailsVal.frame.origin.x, currYPos, detailsVal.frame.size.width, detailsSize.height + 10);
    currYPos += detailsVal.frame.size.height + 20;
    
    mainScrollView.contentSize = CGSizeMake(kiPhoneWidthPortrait, currYPos);
    _skillBackground.frame = CGRectMake(0, 210, kiPhoneWidthPortrait, mainScrollView.contentSize.height - 210 + 300);
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
