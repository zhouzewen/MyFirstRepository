//
//  ZZW_TouchTableView.m
//  ZzwDevelopLibrary
//
//  Created by 周泽文 on 2017/7/26.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

#import "ZZW_TouchTableView.h"
@interface ZZW_TouchTableView(){
    /**
     用结构体将 代理是否响应 代理方法保存起来
     这样就不用每次都要判断 代理是否存在，代理是否响应某个方法了
     只有一个方法的情况下，可以只用一个bool值就可以了，但是如果有多个方法
     只需要在结构体中增加一个成员就可以了，也可以增加一个bool值
     */
    struct{
        unsigned int touchTableView : 1; // c语言 位段   一个二进制位  只能表示0、1,更加节省空间
    }_delegateFlag;
}

@end
@implementation ZZW_TouchTableView

-(void)setTouchDelegate:(id<ZZW_TouchTableViewDelegate>)touchDelegate{
    if (_touchDelegate == nil) {
        _touchDelegate = touchDelegate;
        _delegateFlag.touchTableView = [touchDelegate respondsToSelector:@selector(touchTableView:atPoint:)];
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (_delegateFlag.touchTableView) // 代理能够处理
        [_touchDelegate touchTableView:self atPoint:point];
    
    if ([self pointInside:point withEvent:event] == NO) return nil; // 触点不在table内
    
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) { // 将点击事件交给table的子视图处理
        UIView * childView = self.subviews[i];
        CGPoint childPoint = [self convertPoint:point toView:childView];
        UIView * fitView = [childView hitTest:childPoint withEvent:event];
        
        if (fitView) return fitView;
    }
    return self;
}

@end
