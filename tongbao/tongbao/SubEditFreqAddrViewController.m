//
//  SubEditFrqViewController.m
//  tongbao
//
//  Created by ZX on 16/2/28.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubEditFreqAddrViewController.h"
#import "NearbyViewController.h"
#import "User.h"
#import "SubAddrViewController.h"
@interface SubEditFreqAddrViewController ()
@property (strong, nonatomic) IBOutlet UITextField *addr;
@property (strong, nonatomic) IBOutlet UITextField *contactName;
@property (strong, nonatomic) IBOutlet UITextField *contactPhone;

@property (strong, nonatomic) NSString *callerName;

@end

@implementation SubEditFreqAddrViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.addr.text = self.address;
    self.contactName.text = self.myAddr.contactName;
    self.contactPhone.text = self.myAddr.contactPhone;
    self.table.delegate = self;
    self.callerName = @"SubEditFreqAddrViewController";
}

-(void)viewDidAppear:(BOOL)animated
{
//    NSArray* freqAddrArray = self.freqAddrPlsmk
//    .addressDictionary[@"FormattedAddressLines"];
//    // 将详细地址拼接成一个字符串
//    NSMutableString* freqAddress = [[NSMutableString alloc] init];
//    for(int i = 0 ; i < freqAddrArray.count ; i ++)
//    {
//        [freqAddress appendString:freqAddrArray[i]];
//    }
//   
//    
//    
//    self.addr.text = freqAddress;
//    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger rowNo = indexPath.row;
    if (section==1) {
        if (rowNo == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除订单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                [User deleteFrequentAddress:self.myAddr.id withBlock:^(NSError *error, User *user) {
                    if(error){
                        NSLog(@"Delete Order FAILED!!!!");
                        
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除订单失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }else{
                        
                        
                        
                        NSLog(@"Delete Order succeed");
                        
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除订单成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                            
                            SubAddrViewController *setsubAddrVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                            
                            //使用popToViewController返回并传值到上一页面
                            [self.navigationController popToViewController:setsubAddrVC animated:true];
                            
                            
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
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
