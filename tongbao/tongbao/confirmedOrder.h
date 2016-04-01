//
//  confirmedOrder.h
//  tongbao
//
//  Created by ZX on 16/4/1.
//  Copyright © 2016年 ZX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface confirmedOrder : NSObject

@property (copy, nonatomic) NSString* id ;
@property (copy, nonatomic) NSString* time;
@property (copy, nonatomic) NSString* addressFrom ;
@property (copy, nonatomic) NSString* addressTo ;
@property (copy, nonatomic) NSString* money ;
@property (copy, nonatomic) NSString* fromContactName ;
@property (copy, nonatomic) NSString* fromContactPhone ;
@property (copy, nonatomic) NSString* toContactName ;
@property (copy, nonatomic) NSString* toContactPhone ;
@property (copy, nonatomic) NSString* loadTime ;

@property (copy, nonatomic) NSArray* truckTypes;


@end