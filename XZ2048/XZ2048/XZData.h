//
//  XZData.h
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XZData;

@protocol XZDataDelegate <NSObject>

@optional

- (void)data:(XZData *)data;

@end

@interface XZData : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentScore;
@property (nonatomic, assign) NSInteger bestScore;

@property (nonatomic, weak) id<XZDataDelegate> delegate;


- (void)addData;

- (void)restart;

- (void)swipeUp;
- (void)swipeDown;
- (void)swipeLeft;
- (void)swipeRight;


@end
