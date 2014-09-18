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
        
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundView.image = nil;
        [self addSubview:backgroundView];
        
        _letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _letterLabel.textAlignment = NSTextAlignmentCenter;
        _letterLabel.font = [UIFont fontWithName:[JPFont defaultThinFont] size:self.frame.size.width*0.8];
        _letterLabel.textColor = [UIColor whiteColor];
        [self addSubview:_letterLabel];
        
        _asyncImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _asyncImageView.contentMode = UIViewContentModeScaleAspectFill;
        _asyncImageView.backgroundColor = [UIColor clearColor];
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

- (void)setShouldHideLogo:(BOOL)shouldHideLogo
{
    _shouldHideLogo = shouldHideLogo;
    if(_shouldHideLogo)
        self.image = nil;
    else
        self.image = [UIImage imageNamed:@"avatarIcon"];
}

- (void)setLetter:(NSString *)letter
{
    _letter = letter;
    
    if(!letter || [letter isEqual:@""])
    {
        _letterLabel.hidden = YES;
        return;
    }

    NSString* firstLetter = [[letter substringToIndex:1] uppercaseString];
    _letterLabel.backgroundColor = [JPStyle colorWithLetterVariated:firstLetter];
    _letterLabel.text = firstLetter;
    [self bringSubviewToFront:_letterLabel];
    
    _letterLabel.hidden = NO;
    
    backgroundView.image = [UIImage imageWithColor:_letterLabel.backgroundColor];
}


- (void)setLetterBackColor:(UIColor *)letterBackColor
{
    _letterBackColor = letterBackColor;
    _letterLabel.backgroundColor = letterBackColor;
    
    backgroundView.image = [UIImage imageWithColor:_letterLabel.backgroundColor];
}



- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    
    if(!_imageUrl || [_imageUrl.path isEqual:@""] || !_imageUrl.path)
    {
        self.image = [UIImage imageNamed:@"avatarIcon"];
        backgroundView.image = nil;
    }
    else
    {
        backgroundView.image = [UIImage imageWithColor:[UIColor whiteColor]];
        [[AsyncImageLoader sharedLoader] loadImageWithURL:_imageUrl target:self action:@selector(imageLoaded)];
    }
    
}


- (void)imageLoaded
{
    _asyncImageView.alpha = 0;
    _asyncImageView.image = [[[AsyncImageLoader sharedLoader] cache] objectForKey:self.imageUrl];
    
    [UIView animateWithDuration:0.5 animations:^{
        _asyncImageView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
    }];

}



@end
