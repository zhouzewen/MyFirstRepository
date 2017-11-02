//
//  HttpHelper.m
//  WineValidation
//
//  Created by 周泽文 on 2017/7/14.
//  Copyright © 2017年 Fox. All rights reserved.
//

#import "ZZW_HttpHelper.h"

NSString * const HttpType = @"type";
NSString * const HttpURL = @"url";
NSString * const HttpHead = @"head";
NSString * const HttpBody = @"body";


@interface ZZW_HttpHelper()<NSURLSessionDataDelegate>
@property(nonatomic,strong)NSURLSession * session;
@property(nonatomic,strong)NSMutableData * infoData;
@end


@implementation ZZW_HttpHelper
-(instancetype)init{
    self = [super init];
    if (self) {
        _infoData = [[NSMutableData alloc] init];
    }
    return self;
}
-(void)postRequestWithParams:(NSDictionary *)params{
    NSString * urlStr = params[HttpURL];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    if (!params[HttpHead]) {
        [mRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [mRequest addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    }else{ }
    
    
    mRequest.HTTPMethod = params[HttpType];
    
    if (params[HttpBody]) {
        //        mRequest *httpBody = [NSString stringWithFormat:@"code=%@",code];
        //        mRequest.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask * task = [_session dataTaskWithRequest:mRequest];
    [task resume];
}


#pragma mark -NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    [self.infoData appendData:data];
}

-(void)URLSession:(NSURLSession *)session
             task:(nonnull NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    if (!error) {
        // 调用工具方法 处理data 返回需要的字典
        //        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.infoData options:NSJSONReadingAllowFragments error:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpHelper:didReceiveData:)]) {
            [self.delegate httpHelper:self didReceiveData:[self.infoData copy]];
        }
    } else {
        NSLog(@"%@",error);
    }
    [_session invalidateAndCancel];
}
@end
