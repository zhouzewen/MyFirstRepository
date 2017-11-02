//
//  ZZW_Caculate.h
//  ZZW_DevelopLibrary
//
//  Created by 周泽文 on 2017/7/26.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//



/**
 caculate finger touch point in view , by the seperate line in the middle of the view.
 
 if touch point is on the view left side , this class will return left
 if touch point is on the view right side , this class will return right
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,location) {
    left, // 表示 point 在 view的左半边
    right // 表示 point 在 view的右半边
};
@interface ZZW_Caculate : NSObject
+(location)locationInView:(UIView *)view withPoint:(CGPoint)point;
@end
