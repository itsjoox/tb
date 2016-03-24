//
//  Message.m
//  tongbao
//
//  Created by ZX on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface Message()

@end

@implementation Message
+(NSString*) getType:(NSString*) type{
    NSArray* types = @[@"订单被抢到",@"订单完成",@"正在进行的订单被取消",@"其他消息"];
    return [types objectAtIndex:[type intValue]];
    
}
+(NSString*) getReadStatus:(NSString*) hasRead{
    NSArray* readStatus = @[@"未读",@"已读"];
    return [readStatus objectAtIndex:[hasRead intValue]];
    
}

@end