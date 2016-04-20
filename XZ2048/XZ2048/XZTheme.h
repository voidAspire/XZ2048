//
//  XZTheme.h
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZTheme : NSObject

+ (UIColor *)backgroundColor;

+ (UIColor *)singleBoardColor;

+ (UIColor *)gameBoardColor;

+ (UIColor *)buttonColor;

/** The name of the bold font. */
+ (NSString *)boldFontName;

/** The name of the regular font. */
+ (NSString *)regularFontName;

@end
