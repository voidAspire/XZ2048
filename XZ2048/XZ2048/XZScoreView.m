//
//  XZScoreView.m
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import "XZScoreView.h"
#import "XZTheme.h"

@implementation XZScoreView





- (void)updateAppearance
{
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [XZTheme buttonColor];
    self.title.font = [UIFont fontWithName:[XZTheme boldFontName] size:12];
    self.score.font = [UIFont fontWithName:[XZTheme regularFontName] size:16];
}

-(void)updateWithScore:(NSInteger)score
{
    NSString *scoreString = [[NSString alloc] initWithFormat:@"%ld", score];
    self.score.text = scoreString;
    
}



@end
