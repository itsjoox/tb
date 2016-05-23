//
//  Truck.h
//  tongbao
//
//  Created by ZX on 16/3/29.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Truck : NSObject

@property (copy, nonatomic) NSNumber* type;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSNumber* basePrice;
@property (copy, nonatomic) NSNumber* capacity;
@property (copy, nonatomic) NSNumber* length;
@property (copy, nonatomic) NSNumber* width;
@property (copy, nonatomic) NSNumber* height;
@property (copy, nonatomic) NSNumber* overPrice;
@property (copy, nonatomic) NSNumber* baseDistance;


@end