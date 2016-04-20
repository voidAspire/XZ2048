//
//  XZData.m
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import "XZData.h"

#define NUMBER(i, j) [(NSNumber *)self.dataArray[i][j] intValue]
#define SET_NUMBER(i, j, k) (self.dataArray[i][j] = [NSNumber numberWithInt:k])

@interface XZData  ()

@property (nonatomic, assign) BOOL isMoved;

@end

@implementation XZData

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            NSMutableArray *dataOfLine = [NSMutableArray array];
            for (NSInteger j = 0; j < 4; j++) {
                NSNumber *data = [NSNumber numberWithInt:0];
                [dataOfLine addObject:data];
            }
            [_dataArray addObject:dataOfLine];
        }
        [self addData];
        [self addData];

    }

    return _dataArray;
}

- (NSInteger)currentScore
{
    if (self.isMoved) {
        _currentScore = 0;
        for (NSInteger i = 0; i < 4; i++) {
            for (NSInteger j = 0; j < 4; j++) {
                NSNumber *data = self.dataArray[i][j];
                _currentScore += data.intValue;
            }
        }
    }
    self.bestScore = _currentScore;
    
    return _currentScore;
}

- (void)setBestScore:(NSInteger)bestScore
{
    if (!_bestScore) {
        _bestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"bestScore"];
    }
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSDictionary *dic = @{@"bestScore":@0};
        [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
    });
    if (bestScore > _bestScore) {
        _bestScore = bestScore;
        [[NSUserDefaults standardUserDefaults] setInteger:bestScore forKey:@"bestScore"];
    }
}

- (void)addData
{
    NSInteger x = arc4random_uniform(4);
    NSInteger y = arc4random_uniform(4);
    NSNumber *data = _dataArray[x][y];
    if (data.intValue) {
        data = nil;
        [self addData];
    }else{
        NSInteger k = arc4random_uniform(100);
        if (k > 75) {
            _dataArray[x][y] = [NSNumber numberWithInt:4];
        }else{
            _dataArray[x][y] = [NSNumber numberWithInt:2];
        }
    }
    return;
}

- (void)restart
{
    [self.dataArray removeAllObjects];
    self.dataArray = nil;
    self.currentScore = 0;
}

- (void)swipeUp
{
    self.isMoved = NO;
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 0; j < 4; j++) {
            for (NSInteger x = j + 1; x < 4; x++) {
                if (NUMBER(x, i)) {
                    if (!NUMBER(j, i)) {
                        SET_NUMBER(j, i, NUMBER(x, i));
                        SET_NUMBER(x, i, 0);
                        self.isMoved = YES;
                    }else if (NUMBER(x, i) == NUMBER(j, i)){
                        SET_NUMBER(j, i, NUMBER(x, i) * 2);
                        SET_NUMBER(x, i, 0);
                        self.isMoved = YES;
                    }
                    break;
                }
            }
        }
    }
    if (self.isMoved) {
        [self addData];
    }
    [self isOver];
}

- (void)swipeDown
{
    self.isMoved = NO;
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 3; j >= 0; j--) {
            for (NSInteger x = j - 1; x >= 0; x--) {
                if (NUMBER(x, i)) {
                    if (!NUMBER(j, i)) {
                        SET_NUMBER(j, i, NUMBER(x, i));
                        SET_NUMBER(x, i, 0);
                        self.isMoved = YES;
                    }else if (NUMBER(x, i) == NUMBER(j, i)){
                        SET_NUMBER(j, i, NUMBER(j, i) * 2);
                        SET_NUMBER(x, i, 0);
                        self.isMoved = YES;
                    }
                    break;
                }
            }
        }
    }
    if (self.isMoved) {
        [self addData];
    }
    [self isOver];
}

- (void)swipeLeft
{
    self.isMoved = NO;
    
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger j = 0; j < 4; j++) {
            for (NSInteger x = j + 1; x < 4; x ++) {
                if (NUMBER(i, x)) {
                    if (!NUMBER(i, j)) {
                        SET_NUMBER(i, j, NUMBER(i, x));
                        SET_NUMBER(i, x, 0);
                        self.isMoved = YES;
                    }else if(NUMBER(i, x) == NUMBER(i, j)){
                        SET_NUMBER(i, j, NUMBER(i, x) * 2);
                        SET_NUMBER(i, x, 0);
                        self.isMoved = YES;
                        
                    }
                    break;
                }
            }
        }
        
    }
    if (self.isMoved) {
        [self addData];
    }
    [self isOver];
}

- (void)swipeRight
{
    self.isMoved = NO;
    
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger j = 3; j >= 0; j--) {
            for (NSInteger x = j - 1; x >= 0; x--) {
                if (NUMBER(i, x)) {
                    if (!NUMBER(i, j)) {
                        SET_NUMBER(i, j, NUMBER(i, x));
                        SET_NUMBER(i, x, 0);
                        self.isMoved = YES;
                    }else if(NUMBER(i, x) == NUMBER(i, j)){
                        SET_NUMBER(i, j, NUMBER(i, x) * 2);
                        SET_NUMBER(i, x, 0);
                        self.isMoved = YES;
                        
                    }
                    break;
                }
            }
        }
        
    }
    if (self.isMoved) {
        [self addData];
    }
    [self isOver];
}

- (void)isOver
{
    BOOL die = YES;
    for (int i = 0; i < 4 && die; i++) {
        for (int j = 0; j < 4 ; j++) {
            if (i == 0 && j == 0) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i + 1, j) || NUMBER(i, j) == NUMBER(i, j + 1)) {
                    die = NO;
                    break;
                }
            }else if (i == 0 && j == 3) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i + 1, j) || NUMBER(i, j) == NUMBER(i, j - 1)) {
                    die = NO;
                    break;
                }
            } else if (i == 3 && j == 0) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i - 1, j) || NUMBER(i, j) == NUMBER(i, j + 1)) {
                    die = NO;
                    break;
                }
            } else if (i == 3 && j == 3) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i - 1, j) || NUMBER(i, j) == NUMBER(i, j - 1)) {
                    die = NO;
                    break;
                }
            } else if (i > 0 && i < 3 && j > 0 && j < 3) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i - 1, j) || NUMBER(i, j) == NUMBER(i + 1, j) || NUMBER(i, j) == NUMBER(i, j - 1) || NUMBER(i, j) == NUMBER(i, j + 1)) {
                    die = NO;
                    break;
                }
            } else if (i == 0) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i, j + 1) || NUMBER(i, j) == NUMBER(i, j - 1) || NUMBER(i, j) == NUMBER(i + 1, j)) {
                    die = NO;
                    break;
                }
            } else if (j == 0) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i + 1, j) || NUMBER(i, j) == NUMBER(i - 1, j) || NUMBER(i, j) == NUMBER(i, j + 1)) {
                    die = NO;
                    break;
                }
            } else if (i == 3) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i, j + 1) || NUMBER(i, j) == NUMBER(i, j - 1) || NUMBER(i, j) == NUMBER(i - 1, j)) {
                    die = NO;
                    break;
                }
            } else if (j == 3) {
                if (NUMBER(i, j) == 0 || NUMBER(i, j) == NUMBER(i + 1, j) || NUMBER(i, j) == NUMBER(i - 1, j) || NUMBER(i, j) == NUMBER(i, j - 1)) {
                    die = NO;
                    break;
                }
            }
            
        }
    }
    
    if (die) {
//        [[[UIAlertView alloc] initWithTitle:@"重新开始" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        NSLog(@"死了死了死了死了死了！！！！！！！！！");
        if ([self.delegate respondsToSelector:@selector(date)]) {
            [self.delegate data:self];
        }
    }
}


@end
