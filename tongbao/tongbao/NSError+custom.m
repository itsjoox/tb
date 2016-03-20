//
//  NSError+custom.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/17.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSError+Custom.h"

@implementation NSError (Custom)

+ (instancetype)errorWithCode:(ErrorCode)code andDescription:(NSString *)description
{
    if (code != ErrorCodeUnknown) {
        if ([description length] == 0) {
            description = [self reasonForCode:code];
        }
    }
    NSError *error = [[NSError alloc] initWithDomain:@"com.dongxinbao" code:code userInfo:@{NSLocalizedDescriptionKey: description ? description : [self reasonForCode:ErrorCodeUnknown]}];
    return error;
}

+ (NSString *)reasonForCode:(ErrorCode)code
{
    BOOL chinese = [[[NSLocale preferredLanguages] firstObject] containsString:@"zh-Hans"];
    switch (code) {
        case ErrorCodeNetworkError:
            return chinese ? @"连接服务器失败，请重试。" : @"Failed to connect to the server. Please try again.";
            break;
        case ErrorCodeNotLogged:
            return chinese ? @"您还没有登录，请登录后再试。" : @"You have not logged in yet. Please sign in first.";
            break;
        case ErrorCodeAuthenticateError:
            return chinese ? @"登录失败，请重试。" : @"Permission denied. Please try again.";
            break;
        case ErrorCodeUnknown:
            return chinese ? @"未知错误，请与开发者联系。" : @"Unknown Error. Please contact the developer.";
            break;
        case ErrorCodeIncomplete:
            return chinese ? @"请填写必要信息。" : @"Please enter the necessary information.";
            break;
        case ErrorCodePushClosed:
            return chinese ? @"推送未开启，请在设置中开启推送后再试。" : @"Push notification is disabled. Please enable it and try again.";
            break;
        default:
            return nil;
            break;
    }
}

@end
