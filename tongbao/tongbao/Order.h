//
//  Order.h
//  tongbao
//
//  Created by ZX on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


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
