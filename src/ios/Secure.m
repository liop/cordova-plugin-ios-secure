//
//  CDVSecure.m
//  rqt
//
//  Created by 李正峰 on 15/8/31.
//  Copyright (c) 2015年 bobolzz. All rights reserved.
//

#import "CDVSecure.h"
#import "NSString+addtion.h"
#import <DDASLLogger.h>
@implementation CDVSecure


//给字符串params排序签名
- (void)signedParamsByMd5:(CDVInvokedUrlCommand*)command
{
    id params = [command argumentAtIndex:0];
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        NSString *sign = [self signedMd5:params];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sign];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        NSLog(@"%s %s 参数错误",__FILE__,__FUNCTION__);
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
}

//往params中加入sign和sign_type
- (void)addMd5SignToParma:(CDVInvokedUrlCommand*)command
{
    id params = [command argumentAtIndex:0];
    if (params && [params isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *paramsDict = nil;
        paramsDict = [NSMutableDictionary dictionaryWithDictionary:params];
        [paramsDict setObject:@"MD5" forKey:@"sign_type"];
        NSString *signStr = [self signedMd5:params];
        [paramsDict setObject:signStr forKey:@"sign"];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:paramsDict];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        NSLog(@"%s %s 参数错误",__FILE__,__FUNCTION__);
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (NSString*)signedMd5:(NSDictionary*)params
{
    // 对字段进行字母序排序
    NSMutableArray *sortedKeyArray = [NSMutableArray arrayWithArray:params.allKeys];
    
    [sortedKeyArray sortUsingComparator:^NSComparisonResult(NSString* key1, NSString* key2) {
        return [key1 compare:key2];
    }];
    
    NSMutableString *paramString = [NSMutableString stringWithString:@""];
    
    // 拼接成 A=B&X=Y
    for (NSString *key in sortedKeyArray)
    {
        if ([params[key] isKindOfClass:[NSString class]]){
            if ([params[key] length] != 0)
            {
                [paramString appendFormat:@"&%@=%@", key, params[key]];
            }
            
        }else{
            NSString *value = [NSString stringWithFormat:@"%@",params[key]];
            if ([value length] != 0)
            {
                [paramString appendFormat:@"&%@=%@", key, params[key]];
            }
        }
    }
    
    if ([paramString length] > 1)
    {
        [paramString deleteCharactersInRange:NSMakeRange(0, 1)];    // remove first '&'
    }
    
    
    NSString *signString=nil;
    [paramString appendFormat:@"&key=%@",kMD5key];
    signString = [NSString md5HexDigest:paramString];
    
    return signString;
}


@end
