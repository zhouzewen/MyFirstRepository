//
//  ZZW_TouchTableView.h
//  ZzwDevelopLibrary
//
//  Created by 周泽文 on 2017/7/26.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//


/**
 because UIScrollView can not reponse hit test method 
 so i use UITableView to judge finger scoll on the view
 
 */

#import <UIKit/UIKit.h>
@class ZZW_TouchTableView;
@protocol ZZW_TouchTableViewDelegate <NSObject>
//触点在table上的位置
-(void)touchTableView:(ZZW_TouchTableView *)table atPoint:(CGPoint)point;

@end
@interface ZZW_TouchTableView : UITableView
@property(nonatomic,weak)id<ZZW_TouchTableViewDelegate>touchDelegate;
@end
