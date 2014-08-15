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
        
        _asyncImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _asyncImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    
    if(!letter || [letter isEqual:@""])
        return;

    NSString* firstLetter = [[letter substringToIndex:1] uppercaseString];
    _letterLabel.backgroundColor = [JPStyle colorWithLetterVariated:firstLetter];
    _letterLabel.text = firstLetter;
    [self bringSubviewToFront:_letterLabel];
}


- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    
    [[AsyncImageLoader sharedLoader] loadImageWithURL:_imageUrl target:self action:@selector(imageLoaded)];

}

- (void)imageLoaded
{
    _asyncImageView.alpha = 0;
    _asyncImageView.image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:self.imageUrl];
    
    [UIView animateWithDuration:0.5 animations:^{
        _asyncImageView.alpha = 1.0;
    }];
    
    
    
}


@end
