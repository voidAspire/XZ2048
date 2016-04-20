//
//  XZTheme.m
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import "XZTheme.h"


#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]




@implementation XZTheme


+ (UIColor *)backgroundColor
{
    return RGB(250, 248, 239);
}


+ (UIColor *)singleBoardColor
{
    return RGB(204, 192, 179);
}


+ (UIColor *)gameBoardColor
{
    return RGB(187, 173, 160);
}


+ (UIColor *)buttonColor
{
    return RGB(119, 110, 101);
}

+ (NSString *)boldFontName
{
    return @"AvenirNext-DemiBold";
}


+ (NSString *)regularFontName
{
    return @"AvenirNext-Regular";
}

@end
