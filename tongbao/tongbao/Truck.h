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

@property (copy, nonatomic) NSString* type;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* basePrice;
@property (copy, nonatomic) NSString* capacity;
@property (copy, nonatomic) NSString* length;
@property (copy, nonatomic) NSString* width;
@property (copy, nonatomic) NSString* height;
@property (copy, nonatomic) NSString* overPrice;
@property (copy, nonatomic) NSString* baseDistance;

@end