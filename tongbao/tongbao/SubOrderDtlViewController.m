//
//  SubOrderDtlViewController.m
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubOrderDtlViewController.h"
#import "User.h"
@interface SubOrderDtlViewController ()


@end


@implementation SubOrderDtlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderNoLbl.text = self.myOrderID;
    self.navigationController.toolbarHidden = NO;
    
//    [User getOrderDetail:self.myOrderID withBlock:^(NSError *error, User *user) {
//        if(error){
//            NSLog(@"Get OrderList FAILED!!!!");
//        }else{
//            NSLog(@"Now getting OrderList");
//            confirmedOrder* cfOrderItem = [user.orderList objectAtIndex:0];
//            self.cfOrderItem = cfOrderItem;
//            
//            
//        }
//    }];

    self.orderState.text = self.cfOrderItem.state;
    self.orderTimeLbl.text = self.cfOrderItem.time;
    self.orderPriceLbl.text = [self.cfOrderItem.money stringValue];
    self.srcAddrTxtView.text = self.cfOrderItem.addressFrom;
    self.senderNameTxtFld.text = self.cfOrderItem.fromContactName;
    self.senderTelTxtFld.text = self.cfOrderItem.fromContactPhone;
    
    self.destAddrTxtView.text = self.cfOrderItem.addressTo;
    self.receiverNameTxtFld.text = self.cfOrderItem.toContactName;
    self.receiverTelTxtFld.text = self.cfOrderItem.toContactPhone;
    
    //self.truckTypesTxtFld.text = self.cfOrderItem.truckTypes;
    
    self.loadTimeTxtFld.text = self.cfOrderItem.loadTime;
    
    
    
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