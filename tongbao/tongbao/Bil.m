//
//  Bil.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bill.h"

@interface Bill()

@end

@implementation Bill

+(NSString*) getType:(NSString*) type{
    NSArray* types = @[@"充值",@"提现",@"支付",@"退款",@"到账"];
    return [types objectAtIndex:[type intValue]];
    
}

- (NSString*) contents{
    return [NSString stringWithFormat:@"%@ %@ %@", self.type, self.time,self.money];
}

@end
