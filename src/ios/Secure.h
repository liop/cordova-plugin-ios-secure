//
//  CDVSecure.h
//  rqt
//
//  Created by 李正峰 on 15/8/31.
//  Copyright (c) 2015年 bobolzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
@interface CDVSecure : CDVPlugin

//给字符串params排序签名
- (void)signedParamsByMd5:(CDVInvokedUrlCommand*)command;

//往params中加入sign和sign_type
- (void)addMd5SignToParma:(CDVInvokedUrlCommand*)command;

@end
