//
//  SubEvaluateOrderViewController.h
//  tongbao
//
//  Created by ZX on 16/4/6.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "confirmedOrder.h"
@interface SubEvaluateOrderViewController : UITableViewController<UITableViewDelegate>

@property (nonatomic,copy) NSString* orderId;
@property (nonatomic,copy) confirmedOrder* cfOrderItem;
@end