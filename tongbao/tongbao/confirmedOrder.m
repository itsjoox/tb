//
//  confirmedOrder.m
//  tongbao
//
//  Created by ZX on 16/4/1.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "confirmedOrder.h"
@interface confirmedOrder()

@end

@implementation confirmedOrder

+(NSString*) getState:(NSString*) state{
    NSArray* states = @[@"尚未被抢",@"已经被抢，正在进行",@"已经完成",@"已经取消",@"进行中取消，正在等待司机确认"];
    return [states objectAtIndex:[state intValue]];
    
}


@end
