//
//  DriversPosition.h
//  tongbao
//
//  Created by ZX on 16/4/7.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface DriversPosition : NSObject

@property (copy, nonatomic) NSNumber* id ;
@property (copy, nonatomic) NSString* collectTime;
@property (copy, nonatomic) NSString* receiveTime;
@property (copy, nonatomic) NSString* lat;
@property (copy, nonatomic) NSString* lng;

@end