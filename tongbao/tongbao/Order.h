//
//  Order.h
//  tongbao
//
//  Created by ZX on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//"type":(账单类型)0表示充值 1表示提现 2表示支付 3表示退款 4表示到帐, "time":(交易时间), "money":12(金额),
//"order"(只有type为2,3,4时才有该值):{"id":1,"addressFrom":开始地点,"addressTo":终止地点}

@interface Order : NSObject

@property (copy, nonatomic) NSString* addressFrom ;
@property (copy, nonatomic) NSString* addressFromLat;
@property (copy, nonatomic) NSString* addressFromLng ;
@property (copy, nonatomic) NSString* addressTo ;
@property (copy, nonatomic) NSString* addressToLat ;
@property (copy, nonatomic) NSString* addressToLng ;
@property (copy, nonatomic) NSString* fromContactName ;
@property (copy, nonatomic) NSString* fromContactPhone ;
@property (copy, nonatomic) NSString* toContactName ;
@property (copy, nonatomic) NSString* toContactPhone ;
@property (copy, nonatomic) NSString* loadTime ;
@property (copy, nonatomic) NSString* goodsType ;
@property (copy, nonatomic) NSString* goodsWeight ;
@property (copy, nonatomic) NSString* goodsSize ;
@property (copy, nonatomic) NSString* truckTypes;
@property (copy, nonatomic) NSString* remark;
@property (copy, nonatomic) NSString* payType;
@property (copy, nonatomic) NSString* price;

@end
