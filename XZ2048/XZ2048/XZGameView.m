//
//  XZGameView.m
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import "XZGameView.h"
#import "XZTheme.h"

#define screenSize [UIScreen mainScreen].bounds.size

@interface XZGameView ()

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation XZGameView

-(instancetype)init
{
    CGFloat x = 10;
    CGFloat w = screenSize.width - x * 2;
    CGFloat h = w;
    CGFloat y = (screenSize.height - h) / 2;
    if (self = [super initWithFrame:CGRectMake(x, y, w, h)]) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [XZTheme gameBoardColor];
    }
    [self cards];
    [self addSwipeGesture];
    return self;
}

- (void)addSwipeGesture
{
    UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    upGesture.direction = UISwipeGestureRecognizerDirectionUp;
    downGesture.direction = UISwipeGestureRecognizerDirectionDown;
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:upGesture];
    [self addGestureRecognizer:downGesture];
    [self addGestureRecognizer:leftGesture];
    [self addGestureRecognizer:rightGesture];
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(gameView:withSwipeGesture:)]) {
        [self.delegate gameView:self withSwipeGesture:gesture];
    }
}




-(NSMutableArray *)cards
{
    CGFloat w = (self.bounds.size.width - 5 * 6) / 4;
    CGFloat h = w;
    if (!_cards) {
        _cards = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            NSMutableArray *cardsOfLine = [NSMutableArray array];
            for (NSInteger j = 0; j < 4; j++) {
                CGFloat x = (6 + w) * j + 6;
                CGFloat y = (6 + h) * i + 6;
                UIImageView *cardView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
                cardView.backgroundColor = [XZTheme singleBoardColor];
                cardView.layer.cornerRadius = 6;
                cardView.layer.masksToBounds = YES;
                [self addSubview:cardView];
                [cardsOfLine addObject:cardView];
            }
            [_cards addObject:cardsOfLine];

        }
    }
    
    return _cards;
    
}

- (void)updataGameViewWithData:(NSMutableArray *)date
{
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 0; j < 4; j++) {
            NSNumber *dataNumber = date[i][j];
            UIImageView *imageView = self.cards[i][j];
            if (dataNumber.intValue) {
                [self setImage:self.cards[i][j] withNumber:dataNumber];
            }else{
                imageView.image = nil;
            }

        }
    }
}

- (void)setImage:(UIImageView *)imageView withNumber:(NSNumber *)number
{
    NSString *img = [[NSString alloc] initWithFormat:@"tp%d", number.intValue];
    imageView.image = [UIImage imageNamed:img];
}

@end
