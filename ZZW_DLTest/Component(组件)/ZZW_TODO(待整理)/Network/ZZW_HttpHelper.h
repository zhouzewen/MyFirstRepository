//
//  HttpHelper.h
//  WineValidation
//
//  Created by 周泽文 on 2017/7/14.
//  Copyright © 2017年 Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const HttpType;
extern NSString * const HttpURL;
extern NSString * const HttpHead;
extern NSString * const HttpBody;


@class ZZW_HttpHelper;
@protocol ZZW_HttpHelperDelegate<NSObject>
-(void)httpHelper:(ZZW_HttpHelper *)helper didReceiveData:(NSData *)data;
@end


@interface ZZW_HttpHelper : NSObject
@property(nonatomic,weak)id<ZZW_HttpHelperDelegate>delegate;
/**
 params introduce
 key    type    represent   requestType(can not nil)
 key    url     represent   IP(can not nil)
 key    head    represent   httpHead(default nil)
 key    body    represent   httpbody(default nil)
 */
-(void)postRequestWithParams:(NSDictionary *)params;
@end
