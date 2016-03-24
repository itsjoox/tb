//
//  Bill.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//"type":(账单类型)0表示充值 1表示提现 2表示支付 3表示退款 4表示到帐, "time":(交易时间), "money":12(金额),
//"order"(只有type为2,3,4时才有该值):{"id":1,"addressFrom":开始地点,"addressTo":终止地点}

@interface Bill : NSObject


@property (copy, nonatomic) NSString *type;

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *money;

@property (strong, nonatomic) NSString *contents;
+(NSString*) getType:(NSString*) type;
@end
