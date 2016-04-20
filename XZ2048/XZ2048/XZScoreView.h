//
//  XZScoreView.h
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZScoreView : UIView

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *score;

-(void)updateAppearance;
-(void)updateWithScore: (NSInteger)score;

@end
