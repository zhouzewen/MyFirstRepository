//
//  ZZW_SuspendBallButton.h
//  SuspendBall
//
//  Created by 周泽文 on 2017/7/24.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//



#import <UIKit/UIKit.h>
@class ZZW_SuspendBallButton;
@protocol ZZW_SuspendBallButtonDelegate<NSObject>
-(void)clickButton:(ZZW_SuspendBallButton *)button;
@end
/**
 做成单例
 
 */
@interface ZZW_SuspendBallButton : UIButton

@property (nonatomic, weak) id<ZZW_SuspendBallButtonDelegate> delegate;


@property (nonatomic ,assign) BOOL shouldStickToScreen;/** 松开悬浮球后是否需要黏在屏幕的左右两端  */

+(instancetype)sharedInstance;

/**
 imagePath usage
 if your image in Assets.xcassets , you should pass path param  use @"name"
 but if your is in a bundle , you should use [[NSBundle mainBundle] pathForResource:@"name" ofType:@"type"] or other bundle path
 */
+ (instancetype)suspendBallWithFrame:(CGRect)ballFrame
                            delegate:(id<ZZW_SuspendBallButtonDelegate>)delegate
                   subBallImagePath:(NSString *)path;



@end
