//
//  HNScrollListCell.m
//  HackTheNorth
//
//  Created by Si Te Feng on 8/2/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScrollListCell.h"
#import "UserInterfaceConstants.h"
#import "HNAvatarView.h"
#import "JPStyle.h"
#import "JPFont.h"
#import "HNScrollListItem.h"
#import "AutoScrollLabel.h"
#import "NSString+HNConvenience.h"

const CGFloat HNScrollListCellExternalMargin = 20.0f;
const CGFloat HNScrollListCellInternalMargin = 5.0f;
const CGFloat HNScrollListCellAvatarSize = 40.0f;

@implementation HNScrollListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    self.avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(HNScrollListCellExternalMargin, 10, HNScrollListCellAvatarSize, HNScrollListCellAvatarSize)];
//    [self addSubview:self.avatarView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(HNScrollListCellExternalMargin, 10, kiPhoneWidthPortrait - HNScrollListCellExternalMargin - 65, 22)];
    titleLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
    [self addSubview:titleLabel];

    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(HNScrollListCellExternalMargin, 32, kiPhoneWidthPortrait - 70, 18)];
    subtitleLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    subtitleLabel.textColor = [UIColor grayColor];

    [self addSubview:subtitleLabel];
    
    itemsLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(HNScrollListCellExternalMargin, CGRectGetMaxY(subtitleLabel.frame) + HNScrollListCellInternalMargin, kiPhoneWidthPortrait - 2 * HNScrollListCellExternalMargin, 20)];
    itemsLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    [self addSubview:itemsLabel];
    
    for(UIGestureRecognizer* rec in self.gestureRecognizers)
    {
        rec.delegate = self;
    }
    
    
    return self;
    
}

#pragma mark - Setter Methods

- (void)setTitle:(NSString *)title
{
    _title = title;
    titleLabel.text = title;
}


- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    subtitleLabel.text = subtitle;
    
    [self setAvatarLetter];
}


- (void)setAvatarLetter
{
    if(self.shouldShowAvatarLetter)
    {
        self.avatarView.letter = self.subtitle;
        self.avatarView.letterBackColor = [JPStyle colorWithCompanyName:self.subtitle];
    }
    else
        self.avatarView.letter = nil;
}

- (void)setDetailList:(NSArray *)detailList
{
    _detailList = detailList;
    
    // Build the result string
    NSString *text = @"";
    for (int i = 0; i < [_detailList count] - 1; i++) {
        // Add every string except the last one with a bullet point after.
        NSString *detail = [_detailList objectAtIndex:i];
        text = [text stringByAppendingFormat:@"%@ \u2022 ", detail];
    }
    // Finally, add the last one without the bullet point.
    text = [text stringByAppendingString:[_detailList objectAtIndex:[_detailList count] - 1]];
    
    [itemsLabel setText:text];
}


- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    self.avatarView.imageUrl = imageURL;
}


- (void)setShouldShowAvatarLetter:(BOOL)shouldShowAvatarLetter
{
    _shouldShowAvatarLetter = shouldShowAvatarLetter;
    
    [self setAvatarLetter];
    
}


- (void)setEmail:(NSString *)email
{
    _email = email;
 
    if([email isEqual:@""] || [email rangeOfString:@"@"].location == NSNotFound)
        _email = nil;
}


+ (CGFloat)getCellHeight
{
    return 80;
}



- (void)prepareForReuse
{
    self.title = nil;
    self.subtitle = nil;
    self.availability = @[];
    self.email = nil;
    
    [itemsLabel removeFromSuperview];
    itemsLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(HNScrollListCellExternalMargin, CGRectGetMaxY(subtitleLabel.frame) + HNScrollListCellInternalMargin, kiPhoneWidthPortrait - 2 * HNScrollListCellExternalMargin, 20)];
    itemsLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    [self addSubview:itemsLabel];
}


#pragma mark - Gesture Recognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





@end
