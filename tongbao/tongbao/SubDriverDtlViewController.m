//
//  SubDriverDtlViewController.m
//  tongbao
//
//  Created by ZX on 16/2/28.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubDriverDtlViewController.h"
#import "User.h"
#import "SubDriverViewController.h"
@interface SubDriverDtlViewController ()




@end

@implementation SubDriverDtlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.delegate = self;
    self.driverName.text = self.name;
    self.driverTel.text = self.tel;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger rowNo = indexPath.row;
    if (section==1) {
        if (rowNo == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除司机" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                [User deleteFrequentDriver:self.id withBlock:^(NSError *error, User *user) {
                    if(error){
                        NSLog(@"Delete Driver FAILED!!!!");
                        
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除司机失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }else{
                        
                        
                        
                        NSLog(@"Delete Driver succeed");
                        
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除司机成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                            
                            SubDriverViewController *setsubDriverVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                            //设置table刷新
                            setsubDriverVC.refreshStat = @"refresh";
                            //使用popToViewController返回并传值到上一页面
                            [self.navigationController popToViewController:setsubDriverVC animated:true];
                            
                            
                        }];
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
    //返回时取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end