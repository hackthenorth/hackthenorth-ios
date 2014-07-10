//
//  JPFont.m
//  HackTheNorth
//
//  Created by Si Te Feng on 12/11/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPFont.h"

@implementation JPFont


+ (UIFont*)coolFontOfSize: (CGFloat)size
{
    NSString *ledFontName = @"DBLCDTempBlack";
    
    return [UIFont fontWithName:ledFontName size:size];
    
}


+ (NSString*)defaultBoldFont
{
    return @"HelveticaNeue-Bold";
}


+ (NSString*)defaultBoldItalicFont
{
    return @"HelveticaNeue-BoldItalic";
}




//Regular Series
+ (NSString*)defaultFont
{
    return @"HelveticaNeue";
}



+ (NSString*)defaultItalicFont
{
    return @"HelveticaNeue-Italic";

}





+ (NSString*)defaultMediumFont
{
    return @"HelveticaNeue-Medium";

}



+ (NSString*)defaultLightFont
{
    return @"HelveticaNeue-Light";

}



+ (NSString*)defaultThinFont
{
    return @"HelveticaNeue-Thin";

}





+ (NSString*)defaultUltraLightFont
{
    return @"HelveticaNeue-UltraLight";

}













@end
