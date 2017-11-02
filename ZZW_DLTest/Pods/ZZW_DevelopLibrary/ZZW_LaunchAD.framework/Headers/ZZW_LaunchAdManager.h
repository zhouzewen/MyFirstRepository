//
//  ZZW_LaunchAdManager.h
//  ZZW_LaunchAD
//
//  Created by 周泽文 on 2017/10/31.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZW_LaunchAdManager : NSObject
@property(nonatomic,assign)NSInteger countNum;
@property(nonatomic,strong)UIImage *adImage;
+(instancetype )shareInstance;
@end
