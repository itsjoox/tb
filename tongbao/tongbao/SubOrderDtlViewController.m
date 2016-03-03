//
//  SubOrderDtlViewController.m
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubOrderDtlViewController.h"

@interface SubOrderDtlViewController ()


@end


@implementation SubOrderDtlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderNo.text = self.myOrderNo;
    self.navigationController.toolbarHidden = NO;
    if ([self.myOrderState  isEqual: @"waiting"]) {
        self.left.title = @"取消订单";
        self.right.title = @"再来一单";
    }else if ([self.myOrderState  isEqual: @"now"]){
        self.left.title = @"我要投诉";
        self.right.title = @"确认收货";
    }else if ([self.myOrderState  isEqual: @"finished"]){
        self.left.title = @"查看评价";
        self.right.title = @"再来一单";
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.toolbarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end