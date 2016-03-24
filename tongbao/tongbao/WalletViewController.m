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
#import "Bill.h"

@interface WalletViewController ()

@end


@implementation WalletViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    Bill* test = [[Bill alloc] init];
//    test.type = @"提现";
//    test.time = @"2015-08-09";
//    test.money = @"10";
   
//    _billList = [NSMutableArray arrayWithObjects:test, nil];
    self.billTable.dataSource = self;
    self.billTable.delegate = self;
    __weak typeof(self) weakSelf = self;
    [User showBills:^(NSError *error, User *user) {
        if(error){
            NSLog(@"show bills FAILED!!!!");
        }else{
            NSLog(@"Now getting bills");
             weakSelf.billList = user.billList;
            [weakSelf.billTable reloadData];
            for(Bill* b in weakSelf.billList){
                NSLog(@"%@",b.contents);
            }
            
            
        }
    }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     *   This is an important bit, it asks the table view if it has any available cells
     *   already created which it is not using (if they are offScreen), so that it can
     *   reuse them (saving the time of alloc/init/load from xib a new cell ).
     *   The identifier is there to differentiate between different types of cells
     *   (you can display different types of cells in the same table view)
     */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 @"cell1"];
//        // 获取cell内包含的Tag为1的UILabel
//        UILabel* label = (UILabel*)[cell viewWithTag:1];
//        label.text = [self.tbl objectAtIndex:rowNo];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    /*
     *   Now that we have a cell we can configure it to display the data corresponding to
     *   this row/section
     */
    
    Bill *item = (Bill *)[self.billList objectAtIndex:indexPath.row];
    UILabel* type = (UILabel*)[cell viewWithTag:1];
    type.text = item.type;
    UILabel* time = (UILabel*)[cell viewWithTag:2];
    time.text = item.time;
    UILabel* money = (UILabel*)[cell viewWithTag:3];
    money.text = item.money;
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return _billList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
