//
//  ZZW_AuthorizeAlert.m
//  ZZW_DevelopLibrary
//
//  Created by 周泽文 on 2017/8/3.
//  Copyright © 2017年 zhouzewen. All rights reserved.
//

#import "ZZW_AuthorizeAlert.h"
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>

#define AlertTitle [NSString stringWithFormat:@"%@需要授权才能访问相册",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]]
static NSString * const AlertMessage = @"是否去设置中开启？";
static NSString * const cancelTitle = @"否";
static NSString * const sureTitle = @"是";
@interface ZZW_AuthorizeAlert()<UIAlertViewDelegate>

@end
@implementation ZZW_AuthorizeAlert

-(instancetype)initWithDelegate:(id<ZZW_AuthorizeAlertDelegate>)delegate{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

-(void)checkAuthorizeStatus{
    /**
     1 先判断用户是否开启了访问相册的权限
     2 没有开启 或者 没有确定 就跳转到设置中让用户来设置权限
     
     */
    if ([[UIDevice currentDevice].systemVersion floatValue]> 9.0) { // 系统版本大于9
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"PHAuthorizationStatusAuthorized");
                if ([_delegate respondsToSelector:@selector(authorizeAlert:permitStatus:)]) {
                    [_delegate authorizeAlert:self permitStatus:canAccessPhoto];
                }
            }
            else if (status == PHAuthorizationStatusNotDetermined) {
                NSLog(@"PHAuthorizationStatusNotDetermined");
                
                
            }else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                NSLog(@"没有开启访问相册的权限");
                
                
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:AlertTitle message:AlertMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if ([_delegate respondsToSelector:@selector(authorizeAlert:permitStatus:)]) {
                        [_delegate authorizeAlert:self permitStatus:forbidAccessPhoto];
                    }
                }];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self openSettingURLWithDifferentSystmeVersion];
                }];
                [alert addAction:cancel];
                [alert addAction:sure];
                [(UIViewController *)_delegate presentViewController:alert animated:YES completion:nil];
            }
        }];
        
    }else{// 系统版本小于9
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusNotDetermined) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
            } failureBlock:^(NSError *error) {
                
            }];
        }else if (author == ALAuthorizationStatusAuthorized){
            if ([_delegate respondsToSelector:@selector(authorizeAlert:permitStatus:)]) {
                [_delegate authorizeAlert:self permitStatus:canAccessPhoto];
            }
        }
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:sureTitle, nil];
            [alert show];
        }
    }
}
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    if (buttonIndex == 0) {
        if ([_delegate respondsToSelector:@selector(authorizeAlert:permitStatus:)]) {
            [_delegate authorizeAlert:self permitStatus:forbidAccessPhoto];
        }
    }else if (buttonIndex ==1){
        [self openSettingURLWithDifferentSystmeVersion];
    }
}
-(void)openSettingURLWithDifferentSystmeVersion{
    NSURL * settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version > 10.0) {
        [[UIApplication sharedApplication] openURL:settingUrl options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
            
        }];
    }else{
        [[UIApplication sharedApplication] openURL:settingUrl];
    }
}
@end
