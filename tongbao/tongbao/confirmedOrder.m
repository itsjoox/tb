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
+(NSString*) getTruckTypes:(NSArray*) truckList{
    NSArray* types = @[@"面包车",@"金杯车",@"依维柯",@"小型厢货",@"小型平板",@"中型厢货",@"中型平板",@"大型厢货",@"大型平板"];
    NSMutableString *str = [[NSMutableString alloc]init];
    NSSet* set = [NSSet setWithArray:truckList];
    //NSArray* arr = [NSArray ar];
    NSDictionary* dic;
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    NSMutableArray *sumArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < truckList.count; i++){
        if ([categoryArray containsObject:[truckList objectAtIndex:i]] == NO){
            [categoryArray addObject:[truckList objectAtIndex:i]];
            
            int sum =0;
            for (int j=0; j<truckList.count; j++) {
                if ([truckList objectAtIndex:i]==[truckList objectAtIndex:j]){
                    sum++;
                }
            }
            
            [sumArray addObject:[NSNumber numberWithInt:sum]];
        }
        
    }
    for (int i=0; i<categoryArray.count; i++) {
        int type = [[categoryArray objectAtIndex:i] intValue];
        NSString* num = [[sumArray objectAtIndex:i] stringValue];
        [str appendString:[types objectAtIndex:type]];
        [str appendString:num];
        [str appendString:@"辆 "];
    }
    
    return str;
    
}

@end
