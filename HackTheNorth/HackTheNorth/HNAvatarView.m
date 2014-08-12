//
//  HNAvatarView.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNAvatarView.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "AsyncImageView.h"


@implementation HNAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.image = [UIImage imageNamed:@"avatarIcon"];
        
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = YES;
        
        _letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _letterLabel.textAlignment = NSTextAlignmentCenter;
        _letterLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:self.frame.size.width*0.85];
        _letterLabel.textColor = [UIColor whiteColor];
        [self addSubview:_letterLabel];
        
        _asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_asyncImageView];
        
    }
    return self;
}




- (instancetype)initWithFrame:(CGRect)frame letter: (NSString*)letter
{
    self = [self initWithFrame:frame];
    if(self)
    {
        self.letter = letter;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame imageURL: (NSURL*)url;
{
    self = [self initWithFrame:frame];
    if(self)
    {
        self.imageUrl = url;
    }
    return self;
}


#pragma mark - Setter Methods

- (void)setLetter:(NSString *)letter
{
    _letter = letter;
    
    self.image = nil;
    NSString* firstLetter = [[letter substringToIndex:1] uppercaseString];
    _letterLabel.backgroundColor = [JPStyle colorWithLetter:firstLetter];
    _letterLabel.text = firstLetter;
    [self bringSubviewToFront:_letterLabel];
}


- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    _asyncImageView.imageURL = self.imageURL;
    
}






@end
