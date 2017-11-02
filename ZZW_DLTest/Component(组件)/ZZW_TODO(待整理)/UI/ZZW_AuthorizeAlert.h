//
//  ZZW_AuthorizeAlert.h
//  ZZW_DevelopLibrary
//
//  Created by 周泽文 on 2017/8/3.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

/**
 This class is used to judge that app have authorize to access photo album
 by call checkAuthorizeStatus method this class will get authorize status 
 and user should systhosize -(void)authorizeAlert:(ZZW_AuthorizeAlert *)alert permitStatus:(PhotoPermitStatus)status;
 method deal with two cases forbidAccessPhoto、canAccessPhoto
 */

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PhotoPermitStatus) {
    forbidAccessPhoto=0, // 禁止访问相册
    canAccessPhoto // 能访问相册
    
};
@class ZZW_AuthorizeAlert;
@protocol ZZW_AuthorizeAlertDelegate <NSObject>
@required
-(void)authorizeAlert:(ZZW_AuthorizeAlert *)alert permitStatus:(PhotoPermitStatus)status;
@end

@interface ZZW_AuthorizeAlert : NSObject

@property(nonatomic,weak)id<ZZW_AuthorizeAlertDelegate>delegate;
-(instancetype)initWithDelegate:(id<ZZW_AuthorizeAlertDelegate>)delegate;
-(void)checkAuthorizeStatus;
@end
