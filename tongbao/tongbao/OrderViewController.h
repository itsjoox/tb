//
//  OrderViewController.h
//  tongbao
//
//  Created by ZX on 16/2/20.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubOrderDtlViewController.h"


@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSArray* waitingOrderList;
@property (strong, nonatomic) NSArray* deliveringOrderList;
@property (strong, nonatomic) NSArray* finishedOrderList;
@property (strong, nonatomic) NSArray* canceledOrderList;


- (IBAction)orderState:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *orderStateOutlet;

@end