//
//  SubDriverViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubDriverViewController.h"
#import "SubDriverDtlViewController.h"
#import "User.h"
#import "Driver.h"
@interface SubDriverViewController ()

@end

@implementation SubDriverViewController

@synthesize freqDriverList;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    self.freqDriverList = [[NSArray alloc]init];
    self.table.dataSource = self;
    self.table.delegate = self;

    [User getFrequentDrivers:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get Messages FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
            
            self.freqDriverList = user.freqDriverList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
            //int count=0;
            //            for(Bill* b in weakSelf.billList){
            //                NSLog(@"%d %@",count++,b.contents);
            //            }
            
            
        }
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [User getFrequentDrivers:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get Messages FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
            
            self.freqDriverList = user.freqDriverList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
            //int count=0;
            //            for(Bill* b in weakSelf.billList){
            //                NSLog(@"%d %@",count++,b.contents);
            //            }
            
            
        }
    }];
    
    
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    // 根据行号的奇偶性使用不同的标识符
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    Driver *driverItem = [self.freqDriverList objectAtIndex:rowNo];
    
    // 获取cell内包含的Tag为1的UILabel
    UILabel* driverNameLbl = (UILabel*)[cell viewWithTag:1];
    driverNameLbl.text =driverItem.nickName;
    
    UILabel* driverTelLbl = (UILabel*)[cell viewWithTag:2];
    driverTelLbl.text = driverItem.phoneNum;
    
    
    return cell;

    
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.freqDriverList.count;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubDriverDtlViewController* subDriverDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubDriverDtl"];

    Driver *driverItem = [self.freqDriverList objectAtIndex:rowNo];
    subDriverDtl.name = driverItem.nickName;
    subDriverDtl.tel = driverItem.phoneNum;
  
    [self.navigationController pushViewController:subDriverDtl animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end