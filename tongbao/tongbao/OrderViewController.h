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

@property (strong, nonatomic) NSArray* orders;
@property (strong, nonatomic) NSArray* details;

- (IBAction)orderState:(id)sender;

@end