//
//  Address.h
//  tongbao
//
//  Created by ZX on 16/3/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Address : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *lat;

@property (copy, nonatomic) NSString *lng;
@property (copy, nonatomic) NSString *contactName;
@property (copy, nonatomic) NSString *contactPhone;
@property (copy, nonatomic) NSString *id;

@end