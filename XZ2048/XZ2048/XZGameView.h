//
//  XZGameView.h
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZGameView;

@protocol XZGameViewDelegate <NSObject>

@optional

- (void)gameView:(XZGameView *)gameView withSwipeGesture:(UISwipeGestureRecognizer *)gesture;


@end


@interface XZGameView : UIView

@property (nonatomic, weak) id<XZGameViewDelegate> delegate;

- (void)updataGameViewWithData:(NSMutableArray *)date;

@end
