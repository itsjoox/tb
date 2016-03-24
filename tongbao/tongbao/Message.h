//
//  Message.h
//  tongbao
//
//  Created by ZX on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//"type"(类型):0:订单被抢到（通知货主）1:订单完成（通知司机）2: 正在进行的订单被取消(通知司机)3：其他消息
//"content":消息内容,"hasRead"(是否已读):0未读,1已读,"time"(时间):消息产生的时间,
//"objectId":type为012时表示订单id


@interface Message : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *type;

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *hasRead;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *objectId;

+(NSString*) getType:(NSString*) type;
+(NSString*) getReadStatus:(NSString*) type;
@end
