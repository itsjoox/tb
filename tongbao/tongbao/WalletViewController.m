//
//  WalletViewController.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalletViewController.h"
#import "User.h"

@interface WalletViewController ()

@end


@implementation WalletViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)recharge:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"充值金额" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入要充值的金额";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *new = alert.textFields.firstObject;
        NSLog(@"充值金额是！！%@",new.text);
        [User rechargeMoney:[new.text intValue] withBlock:^(NSError *error, User *user)
         {
             if (error) {
                 NSLog(@"recharge FAILED!!!!");
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提现失败" message:@"金额不正确" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                 [alertController addAction:okAction];
                 [self presentViewController:alertController animated:YES completion:nil];
             }else{
                 
             }
         }];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)withdraw:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现金额" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入要提现的金额";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *new = alert.textFields.firstObject;
        NSLog(@"提现金额是！！%@",new.text);
        [User withdrawMoney:[new.text intValue] withBlock:^(NSError *error, User *user)
         {
             if (error) {
                 NSLog(@"withdraw FAILED!!!!");
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提现失败" message:@"金额不正确" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                 [alertController addAction:okAction];
                 [self presentViewController:alertController animated:YES completion:nil];
             }else{
                 
             }
         }];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
