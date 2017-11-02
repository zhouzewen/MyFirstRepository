//
//  ZZW_LaunchAdManager.m
//  ZZW_LaunchAD
//
//  Created by 周泽文 on 2017/10/31.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

#import "ZZW_LaunchAdManager.h"

@interface ZZW_LaunchAdManager()

@property(nonatomic,strong)UIButton *cdBtn;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ZZW_LaunchAdManager

+(instancetype )shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _countNum = 4;
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self addLaunchAd];
        }];
    }
    return self;
}

-(void)addLaunchAd{
    //从沙盒中取出一个张图片放到界面上，3秒钟之后移除他
    
    // 背景广告图
    _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (self.adImage) {
        _imageView.image = self.adImage;
    }else{
        UIImage *image = [UIImage imageNamed:@"CocoaPods私有库原理图"];
        _imageView.image = image;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    // 倒计时按钮
    _cdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cdBtn setBackgroundColor:[UIColor cyanColor]];
    [_cdBtn setTitle:[NSString stringWithFormat:@"%ld",_countNum] forState:UIControlStateNormal];
    [_cdBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_cdBtn setFrame:CGRectMake(100, 100, 100, 50)];
    [_cdBtn addTarget:self action:@selector(removeAD:) forControlEvents:UIControlEventTouchUpInside];
    //    [[UIApplication sharedApplication].keyWindow addSubview:_cdBtn];
    [_imageView addSubview:_cdBtn];
    
    // 定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [_timer fire];
    
}
-(void)removeAD:(UIButton *)button{
    [self removeView];
}
-(void)countDown:(NSTimer *)timer{
    _countNum --;
    [_cdBtn setTitle:[NSString stringWithFormat:@"%ld",_countNum] forState:UIControlStateNormal];
    if (_countNum == 0) {
        [self removeView];
    }
}
-(void)removeView{
    [_timer invalidate];
    _timer = nil;
    [UIView animateWithDuration:0.3f animations:^{
        _imageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_imageView removeFromSuperview];
    }];
}
@end

