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
    shadowView.layer.cornerRadius = imageView.layer.cornerRadius;
    shadowView.layer.shadowOffset = CGSizeMake(4, 8);
    shadowView.layer.shadowOpacity = 0.5;
    shadowView.layer.shadowRadius = 5;
    [self.view insertSubview:shadowView belowSubview:imageView];
    
    UILabel* orgLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 60, kiPhoneWidthPortrait-130, 25)];
    orgLabel.text = @"Organization";
    orgLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:orgLabel];

    org = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 85, kiPhoneWidthPortrait-130, 20)];
    org.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    org.textColor = [UIColor darkGrayColor];
    [self.view addSubview:org];

    UILabel* avaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 115, kiPhoneWidthPortrait-130, 25)];
    avaiLabel.text = @"Availability";
    avaiLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:avaiLabel];
    
    
    avai = [[UITextView alloc] initWithFrame:CGRectMake(125, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 140, kiPhoneWidthPortrait-130, 70)];
    avai.backgroundColor = [UIColor clearColor];
    avai.editable = NO;
    avai.selectable = NO;
    avai.textContainer.lineFragmentPadding = 0;
    avai.textContainerInset = UIEdgeInsetsZero;
    avai.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    avai.textColor = [UIColor darkGrayColor];
    
    [self.view addSubview:avai];
    
    /////////////////////////////////////////////////////
    
    UILabel* skillLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 200, kiPhoneWidthPortrait-20, 30)];
    skillLabel.text = @"Skills";
    skillLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:skillLabel];
    
    
    skillVal = [[UITextView alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 230, kiPhoneWidthPortrait-20, 70)];
    skillVal.backgroundColor = [UIColor clearColor];
    skillVal.editable = NO;
    skillVal.selectable = NO;
    skillVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    skillVal.textColor = [JPStyle interfaceTintColor];
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
        [skillText appendString:[NSString stringWithFormat:@"%@, ", skill]];
    }
    
    if(skillText.length>=2)
        skillVal.text = [skillText substringToIndex:skillText.length-2];
    

}












- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
