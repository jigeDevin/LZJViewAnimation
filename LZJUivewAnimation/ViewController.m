//
//  ViewController.m
//  LZJUivewAnimation
//
//  Created by 梁志基 on 16/2/18.
//  Copyright © 2016年 梁志基. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *tmpImgView;
@property (nonatomic, assign) BOOL isFlipped;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-60, self.view.bounds.size.height, 120, 240)];
    _imgView.image = [UIImage imageNamed:@"02.png"];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    _imgView.userInteractionEnabled = YES;
   // _imgView.center = self.view.center;
    [self.view addSubview:_imgView];
    
//    _tmpImgView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    _tmpImgView.image = [UIImage imageNamed:@"02动态.png"];
//    _tmpImgView.contentMode = UIViewContentModeScaleAspectFill;
//    _tmpImgView.clipsToBounds = YES;
//    _tmpImgView.userInteractionEnabled = YES;
//    _tmpImgView.center = self.view.center;
   // [self.view addSubview:_tmpImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(transition)];
    [_imgView addGestureRecognizer:tap];
    
    //弹簧效果
    [UIView animateWithDuration:0.8f delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imgView.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)transition
{
    /*
     1.UIViewAnimationOptionTransitionFlipFromLeft/Right/Top/Bottom
     翻转
     2.UIViewAnimationOptionTransitionCurlUp/Down
     翻页
     3.UIViewAnimationOptionTransitionCrossDissolve
     淡出淡入
     */
    __weak ViewController *weak_self = self;
    [UIView transitionWithView:_imgView duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [weak_self flip];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:_imgView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [weak_self flip];
        } completion:^(BOOL finished) {
            [UIView transitionWithView:_imgView duration:1.0f options:UIViewAnimationOptionTransitionCurlDown animations:^{
                [weak_self flip];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}
- (void)flip
{
    if (!_isFlipped) {
        _imgView.image = [UIImage imageNamed:@"02动态.png"];
        _isFlipped = YES;
    }else{
        _imgView.image = [UIImage imageNamed:@"02.png"];
        _isFlipped = NO;
    }
//    [_imgView removeFromSuperview];
//    [self.view addSubview:_tmpImgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
