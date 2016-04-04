//
//  SubOrderDtlViewController.m
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubOrderDtlViewController.h"
#import "User.h"
#import "OrderViewController.h"

@interface SubOrderDtlViewController ()


@end


@implementation SubOrderDtlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderNoLbl.text = self.myOrderID;
    self.navigationController.toolbarHidden = NO;
//    
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

- (IBAction)leftBtn:(id)sender {
    if ([self.left.title isEqualToString:@"取消订单"]) {
        
        
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消订单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [User cancelOrder:self.myOrderID withBlock:^(NSError *error, User *user) {
                if(error){
                    NSLog(@"Cancel Order FAILED!!!!");
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消订单失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }else{
                    
                    
                    
                    NSLog(@"Cancel Order succeed");
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消订单成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
                        
                        OrderViewController *setOrderVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                        
                        //使用popToViewController返回并传值到上一页面
                        [self.navigationController popToViewController:setOrderVC animated:true];
                        
                        
                    }
                        ];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                  
                }
            }];
            
        }];
        
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        

    }
}

- (IBAction)rightBtn:(id)sender {
}
@end