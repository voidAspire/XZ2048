//
//  ViewController.m
//  XZ2048
//
//  Created by shine on 16/3/22.
//  Copyright © 2016年 shine. All rights reserved.
//

#import "ViewController.h"
#import "XZTheme.h"
#import "XZScoreView.h"
#import "XZGameView.h"
#import "XZData.h"


@interface ViewController () <XZGameViewDelegate, XZDataDelegate>

@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (weak, nonatomic) IBOutlet XZScoreView *scoreView;
@property (weak, nonatomic) IBOutlet XZScoreView *bestView;

@property (strong, nonatomic) XZGameView *gameView;
@property (strong, nonatomic) XZData *dataManager;

- (IBAction)restartClick;
@end

@implementation ViewController

- (XZGameView *)gameView
{
    if (!_gameView) {
        _gameView = [[XZGameView alloc] init];
        [self.view addSubview:_gameView];
        _gameView.delegate = self;
    }
    
    return _gameView;
}

-(XZData *)dataManager
{
    if (!_dataManager) {
        _dataManager = [[XZData alloc] init];
        _dataManager.delegate = self;
    }
    
    return _dataManager;
}

- (void)updateAll
{
    [self.scoreView updateWithScore:self.dataManager.currentScore];
    [self.bestView updateWithScore:self.dataManager.bestScore];
    [self.gameView updataGameViewWithData:self.dataManager.dataArray];
}

- (IBAction)restartClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重新开始吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dataManager restart];
        [self updateAll];
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XZTheme backgroundColor];
    [self.scoreView updateAppearance];
    [self.bestView updateAppearance];
    self.restartButton.layer.cornerRadius = 6;
    self.restartButton.layer.masksToBounds = YES;
    self.restartButton.backgroundColor = [XZTheme buttonColor];
    [self updateAll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XZGameViewDelegateMethod
- (void)gameView:(XZGameView *)gameView withSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            [self.dataManager swipeUp];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self.dataManager swipeDown];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self.dataManager swipeLeft];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self.dataManager swipeRight];
            break;
            
        default:
            break;
    }
    [self updateAll];
}

#pragma mark - XZDataDelegateMethod
- (void)data:(XZData *)data
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重新开始" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dataManager restart];
        [self updateAll];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}


/** for debuging  */
- (IBAction)numberClick:(UIButton *)sender {
    for (NSInteger i = 0; i < sender.tag; i ++) {
        //[self.dataManager addData];
        NSInteger x = arc4random_uniform(4);
        switch (x) {
            case 0:
                [self.dataManager swipeUp];
//                [self updateAll];
                break;
            case 1:
                [self.dataManager swipeDown];
//                [self updateAll];
                break;
            case 2:
                [self.dataManager swipeLeft];
//                [self updateAll];
                break;
            case 3:
                [self.dataManager swipeRight];
//                [self updateAll];
                break;
                
            default:
                break;
        }
    }
    [self updateAll];
}


@end
