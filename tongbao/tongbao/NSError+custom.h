//
//  NSError+custom.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/17.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ErrorCode) {
    ErrorCodeNetworkError = 1001,
    ErrorCodeNotLogged = 1002,
    ErrorCodeAuthenticateError = 1003,
    ErrorCodeIncomplete = 1004,
    ErrorCodePushClosed = 1005,
    ErrorCodeUnknown = 1099,
    ErrorCodeSplitOrder = 1006
};

@interface NSError (Custom)

+ (instancetype)errorWithCode:(ErrorCode)code andDescription:(NSString *)description;
+ (NSString *)reasonForCode:(ErrorCode)code;

@end
