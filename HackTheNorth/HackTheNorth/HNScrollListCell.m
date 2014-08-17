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
#import "HNScrollView.h"

@implementation HNScrollListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.separatorInset = UIEdgeInsetsMake(0, kiPhoneWidthPortrait, 0, 0);
    
    self.avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [self addSubview:self.avatarView];
    
    titleLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(65, 10, kiPhoneWidthPortrait - 70, 22)];
    titleLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:18];
    [self addSubview:titleLabel];

    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 32, kiPhoneWidthPortrait - 70, 18)];
    subtitleLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    subtitleLabel.textColor = [UIColor grayColor];

    [self addSubview:subtitleLabel];
    
    
    scrollListView = [[HNScrollView alloc] initWithFrame:CGRectMake(0, 60, kiPhoneWidthPortrait, 35)];
    scrollListView.showsHorizontalScrollIndicator = NO;

    [self addSubview:scrollListView];
    
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
    
    CGFloat currXPos = 10;
    
    for(NSString* itemName in detailList)
    {
        NSString* capItemName = itemName;
        if(itemName && ![itemName isEqual:@""])
        {
            NSString* cap = [[itemName substringToIndex:1] uppercaseString];
            NSString* half = [itemName substringFromIndex:1];
            capItemName = [cap stringByAppendingString:half];
        }
        
        CGFloat itemWidth = [HNScrollListItem widthWithString: capItemName];
        
        HNScrollListItem* itemView = [[HNScrollListItem alloc] initWithFrame:CGRectMake(currXPos, 0, itemWidth, scrollListView.frame.size.height)];
        itemView.text = capItemName;
        currXPos += itemWidth + 10;
        
        [scrollListView addSubview:itemView];
    }
    
    scrollListView.contentSize = CGSizeMake(currXPos, scrollListView.frame.size.height);
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


- (void)prepareForReuse
{
    for(UIView* subview in [scrollListView subviews])
    {
        [subview removeFromSuperview];
    }
    
    scrollListView.contentSize = CGSizeMake(0, 0);
    scrollListView.contentOffset = CGPointMake(0, 0);
    
    self.title = nil;
    self.subtitle = nil;
    self.availability = @[];
    self.email = nil;    
}


#pragma mark - Gesture Recognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





@end
