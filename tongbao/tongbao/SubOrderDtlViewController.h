//
//  SubOrderDtlViewController.h
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SubOrderDtlViewController : UITableViewController

@property (strong, nonatomic) NSString* myOrderState;

@property (strong, nonatomic) NSString* myOrderTitle;
@property (strong, nonatomic) NSString* myOrderNo;
@property (strong, nonatomic) NSString* myOrderDtl;
@property (strong, nonatomic) IBOutlet UILabel *orderNo;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *left;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *right;

@end

