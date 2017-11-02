//
//  ZZW_Caculate.m
//  ZZW_DevelopLibrary
//
//  Created by 周泽文 on 2017/7/26.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

#import "ZZW_Caculate.h"

@implementation ZZW_Caculate
+(location)locationInView:(UIView *)view withPoint:(CGPoint)point{
    CGFloat width = view.frame.size.width;
    if (point.x > width/2) {
        return right;
    }
    return left;
}
@end
