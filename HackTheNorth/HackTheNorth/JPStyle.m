//
//  JPStyle.m
//  HackTheNorth
//
//  Created by Si Te Feng on 12/8/2013.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#import "JPStyle.h"
#import "UIColor+RGBValues.h"

@implementation JPStyle


#pragma mark - Device Verification

+(BOOL) iPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}


+(BOOL) iOS7
{
	return [[UIDevice currentDevice].systemVersion hasPrefix:@"7"];
}


+(BOOL) iPhone4Inch
{
    return ([UIScreen mainScreen].bounds.size.height == 568.0) ? YES : NO;
}


#pragma mark - User Interface Colors
+(UIColor*) interfaceTintColor
{
    return [JPStyle colorWithName:@"blue"];
}

+(void)applyGlobalStyle
{
    [[UINavigationBar appearance] setTintColor:[JPStyle interfaceTintColor]];
    [[UISearchBar appearance] setTintColor:[JPStyle interfaceTintColor]];
    [[UITabBar appearance] setTintColor:[JPStyle interfaceTintColor]];
}


#pragma mark - User Interface Colors


+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}


+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *redHex;
    NSString *greenHex;
    NSString *blueHex;
    
    if ([hex length] == 6)
    {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(0, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(2, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(4, 2)]];
    }
    else if ([hex length] == 7)
    {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    }
    else {
        redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(2, 2)]];
        greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(4, 2)]];
        blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(6, 2)]];
    }
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [self colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}




+ (UIColor*)rainbowColorWithIndex: (NSUInteger)index //6 colors
{
    UIColor* color = [UIColor lightGrayColor];
    
    switch (index%7)
    {
        case 0:
            color = [self colorWithName:@"red"]; //red
            break;
        case 1:
            color = [self colorWithName:@"purple"]; //purple
            break;
        case 2:
            color = [self colorWithName:@"blue"]; //blue
            break;
        case 3:
            color = [self colorWithName:@"indigo"]; //indigo
            break;
        case 4:
            color = [self colorWithName:@"green"]; //green
            break;
        case 5:
            color = [self colorWithName:@"orange"]; //orange
            break;
        case 6:
            color = [self colorWithName:@"grey"]; //grey
            break;
            
        default:
            NSLog(@"--Error--No Color Available");
            break;
    }

    
    return  color;
}




+ (UIColor*)translucentRainbowColorWithIndex: (NSUInteger)index
{
    UIColor* color = [self rainbowColorWithIndex:index];
    
    return  [color colorWithAlphaComponent:0.4];
}


+ (UIColor*)whiteTranslucentRainbowColorWithIndex: (NSUInteger)index
{
    CGFloat red,green,blue, a;
    UIColor* tempColor = [self rainbowColorWithIndex:index];
    
    BOOL returnColor = [tempColor getRed:&red green:&green blue:&blue alpha:&a];
    
    if(returnColor)
    {
        tempColor = [UIColor colorWithRed:red+0.2 green:green+0.2 blue:blue+0.2 alpha:a];
    }
  
    return tempColor;
}



+ (UIColor*)backgroundRainbowColorWithIndex: (NSUInteger)index
{
    UIColor* color = [UIColor lightGrayColor];
    color = [self rainbowColorWithIndex:index];
    return  color;
}





+ (UIColor*)colorWithName: (NSString*)colorName
{
    UIColor* returnColor = [UIColor darkGrayColor];
    
    if([colorName isEqualToString:@"blue"]) //light blue bars
    {
        returnColor = [self colorWithHex:@"79A5FF" alpha:1];
    }
    else if([colorName isEqualToString:@"green"]) //light green button
    {
        returnColor = [self colorWithHex:@"00CF03" alpha:1];
    }
    
    else if([colorName isEqualToString:@"red"]) //calendar header
    {
        returnColor = [self colorWithHex:@"FF5F5C" alpha:1];
    }
    else if([colorName isEqual:@"grey"])
    {
        returnColor = [self colorWithHex:@"AFAFAF" alpha:1];
    }
    else if([colorName isEqual:@"purple"])
    {
        returnColor = [self colorWithHex:@"D291FF" alpha:1];
    }
    else if([colorName isEqual:@"indigo"])
    {
        returnColor = [self colorWithHex:@"04CAB0" alpha:1];
    }
    else if([colorName isEqual:@"orange"])
    {
        returnColor = [self colorWithHex:@"FFA73D" alpha:1];
    }
    else if([colorName isEqual:@"tBlack"])
    {
        returnColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    else if([colorName isEqual: @"tWhite"])
    {
        returnColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    else if([colorName isEqual:@"white"])
    {
        returnColor = [UIColor whiteColor];
    }
    else if([colorName isEqual: @"darkGreen"])
    {
        returnColor = [self colorWithHex:@"00A202" alpha:1];
    }
    else
    {
        NSLog(@"--Error--No Color Available");
    }
    
    return returnColor;
}



+ (UIColor*)colorWithLetter: (NSString*)letter
{
    NSString* character = @"";
    if(letter.length > 0) {
        character = [[letter substringToIndex:1] lowercaseString];
    }
    
    UIColor* color = [self rainbowColorWithIndex:(arc4random()%6)];
    
    if([character isEqual:@"a"])
    {
        color = [self rainbowColorWithIndex:0];
    }
    else if([character isEqual:@"b"])
    {
        color = [self rainbowColorWithIndex:1];
    }
    else if([character isEqual:@"c"])
    {
        color = [self rainbowColorWithIndex:2];
    }
    else if([character isEqual:@"d"])
    {
        color = [self rainbowColorWithIndex:3];
    }
    else if([character isEqual:@"e"])
    {
        color = [self rainbowColorWithIndex:4];
    }
    else if([character isEqual:@"f"])
    {
        color = [self rainbowColorWithIndex:5];
    }
    else if([character isEqual:@"g"])
    {
        color = [UIColor grayColor];
    }
    else if([character isEqual:@"h"])
    {
        color = [self backgroundRainbowColorWithIndex:0];
    }
    else if([character isEqual:@"i"])
    {
        color = [self backgroundRainbowColorWithIndex:6];
    }
    else if([character isEqual:@"j"])
    {
        color = [self backgroundRainbowColorWithIndex:1];
    }
    else if([character isEqual:@"k"])
    {
        color = [self backgroundRainbowColorWithIndex:3];
    }
    else if([character isEqual:@"l"])
    {
        color = [self backgroundRainbowColorWithIndex:4];
    }
    else if([character isEqual:@"m"])
    {
        color = [self backgroundRainbowColorWithIndex:5];
    }
    else if([character isEqual:@"n"])
    {
        color = [self rainbowColorWithIndex:0];
    }
    else if([character isEqual:@"o"])
    {
        color = [self rainbowColorWithIndex:3];
    }
    else if([character isEqual:@"p"])
    {
        color = [self rainbowColorWithIndex:2];
    }
    else if([character isEqual:@"q"])
    {
        color = [self rainbowColorWithIndex:1];
    }
    else if([character isEqual:@"r"])
    {
        color = [self rainbowColorWithIndex:4];
    }
    else if([character isEqual:@"s"])
    {
        color = [self rainbowColorWithIndex:5];
    }
    else if([character isEqual:@"t"])
    {
        color = [self backgroundRainbowColorWithIndex:6];
    }
    else if([character isEqual:@"u"])
    {
        color = [self backgroundRainbowColorWithIndex:0];
    }
    else if([character isEqual:@"v"])
    {
        color = [self backgroundRainbowColorWithIndex:1];
    }
    else if([character isEqual:@"w"])
    {
        color = [self backgroundRainbowColorWithIndex:4];
    }
    else if([character isEqual:@"x"])
    {
        color = [self backgroundRainbowColorWithIndex:3];
    }
    else if([character isEqual:@"y"])
    {
        color = [self backgroundRainbowColorWithIndex:6];
    }
    else if([character isEqual:@"z"])
    {
        color = [self backgroundRainbowColorWithIndex:5];
    }
    else
    {
        color = [UIColor darkGrayColor];
    }
    
    return  color;
}


+ (UIColor*)colorWithLetterVariated: (NSString*)letter
{
    NSString* character = @"";
    if(letter.length > 0) {
        character = [[letter substringToIndex:1] lowercaseString];
    }
    
    UIColor* color = [self rainbowColorWithIndex:(arc4random()%6)];
    
    if([character isEqual:@"a"])
    {
        color = [self rainbowColorWithIndex:0];
    }
    else if([character isEqual:@"b"])
    {
        color = [self rainbowColorWithIndex:1];
    }
    else if([character isEqual:@"c"])
    {
        color = [self rainbowColorWithIndex:2];
    }
    else if([character isEqual:@"d"])
    {
        color = [self rainbowColorWithIndex:3];
    }
    else if([character isEqual:@"e"])
    {
        color = [self rainbowColorWithIndex:4];
    }
    else if([character isEqual:@"f"])
    {
        color = [self rainbowColorWithIndex:5];
    }
    else if([character isEqual:@"g"])
    {
        color = [UIColor grayColor];
    }
    else if([character isEqual:@"h"])
    {
        color = [[self backgroundRainbowColorWithIndex:0] lighterColor];
    }
    else if([character isEqual:@"i"])
    {
        color = [[self backgroundRainbowColorWithIndex:6] lighterColor];
    }
    else if([character isEqual:@"j"])
    {
        color = [[self backgroundRainbowColorWithIndex:1]lighterColor];
    }
    else if([character isEqual:@"k"])
    {
        color = [[self backgroundRainbowColorWithIndex:3]lighterColor];
    }
    else if([character isEqual:@"l"])
    {
        color = [[self backgroundRainbowColorWithIndex:4]lighterColor];
    }
    else if([character isEqual:@"m"])
    {
        color = [[self backgroundRainbowColorWithIndex:5]lighterColor];
    }
    else if([character isEqual:@"n"])
    {
        color = [UIColor darkGrayColor];
    }
    else if([character isEqual:@"o"])
    {
        color = [[self rainbowColorWithIndex:3]darkerColor];
    }
    else if([character isEqual:@"p"])
    {
        color = [[self rainbowColorWithIndex:2]darkerColor];
    }
    else if([character isEqual:@"q"])
    {
        color = [[self rainbowColorWithIndex:1]darkerColor];
    }
    else if([character isEqual:@"r"])
    {
        color = [[self rainbowColorWithIndex:4]darkerColor];
    }
    else if([character isEqual:@"s"])
    {
        color = [[self rainbowColorWithIndex:5]darkerColor];
    }
    else if([character isEqual:@"t"])
    {
        color = [[self backgroundRainbowColorWithIndex:6]darkerColor];
    }
    else if([character isEqual:@"u"])
    {
        color = [UIColor lightGrayColor];
    }
    else if([character isEqual:@"v"])
    {
        color = [[self rainbowColorWithIndex:0] darkerColor];
    }
    else if([character isEqual:@"w"])
    {
        color = [UIColor redColor];
    }
    else if([character isEqual:@"x"])
    {
        color = [[UIColor orangeColor] darkerColor];
    }
    else if([character isEqual:@"y"])
    {
        color = [UIColor purpleColor];
    }
    else if([character isEqual:@"z"])
    {
        color = [UIColor blueColor];
    }
    else
    {
        color = [UIColor blackColor];
    }
    
    return  color;
}


+ (UIColor*)colorWithCompanyName: (NSString*)companyName
{
    NSString* name = [companyName lowercaseString];
    UIColor* color = [UIColor blackColor];
    
    NSDictionary* colorDict = @{@"facebook":@"3B5998", @"bloomberg":@"000000",
                                @"pagerduty":@"09C700", @"velocity":@"16446D",
                                @"kik":@"88D100", @"unity":@"000000",
                                @"pebble":@"000000", @"mozilla":@"C9D1CF",
                                @"slyce":@"00C0FF", @"yelp":@"FF0900",
                                @"yext":@"003B6B", @"stackoverflow":@"FF8000",
                                @"magnet":@"006EC0", @"moxtra":@"00A6FF",
                                @"big viking":@"000000", @"microsoft":@"0016FF",
                                @"wit.ai":@"5196CF", @"spark":@"56ACDD",
                                @"estimote":@"00AC8C", @"base":@"00BD1F",
                                @"a thinking ape":@"4A4D4D", @"kloudless":@"A38700",
                                @"ethereum":@"6E718F", @"5∞":@"000000",@"5infinity":@"000000",
                                @"university of waterloo":@"EE9600", @"y combinator":@"ED6C00",
                                @"mlh":@"296792", @"techyon":@"666569"
                                
                                };
    
    NSString* colorVal = [colorDict valueForKey:name];
    if(colorVal)
        color = [self colorWithHex:colorVal alpha:1];
    
    if([companyName isEqual:@"hack the north"] || [companyName isEqual:@"hackthenorth"])
    {
        color = [self interfaceTintColor];
    }
    
    return color;
}



@end





@implementation UIImage (Beautify)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage*)imageWithAlpha: (CGFloat) alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0,0, self.size.width, self.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    
    CGContextDrawImage(context, area, self.CGImage);
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}










@end








//// Colours
//#define kWhiteText 				0xFFFFFF
//#define kDeactiveText 			0xB0B0B0
//#define kRegularText 			0x4A4A4A
//#define kLightenedText 			0x7B7979
//#define kGreenRegularText 		0x586B70
//#define kGreenLightenedText 	0x648991
//#define kUnitBoardCell 			0xE2ECF1
//#define kLightBlueText 			0x6BE0D8
//#define kLightGrey 				0x666666
//
//// Cell Background Colors
//#define kLightBlue 				0x9AD4ED
//#define klightPink 				0xF7BBC5
//#define kRed 					0xF76858
//#define kYellow 				0xEDDC88
//#define kOrange 				0xFCAE54
//#define kGreen 					0x9AC555
//#define kBlue 					0x42A9De
//#define kPurple 				0xC39BCC
//#define kBrown 					0xB2A786
//#define kLightGreen 			0xBDCCD4
//#define kLightGreyBackground 	0xF2F2F2
//#define kDarkGreyBackground 	0xCFCED1
//#define kDarkLine 				0x8C9EA7
//#define kRefreshBackground 		0xCCCCCC
//#define kDarkBlueColorHex       0x6D8991
//#define kDarkBlueColorRGB       [UIColor colorWithRed:109/255.0 green:137/255.0 blue:145/255.0 alpha:1.0]
//#define kBorderColor			0x97BFBC




