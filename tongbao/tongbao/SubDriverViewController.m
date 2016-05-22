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
    self.freqDriverList = [[NSMutableArray alloc]init];
    self.table.dataSource = self;
    self.table.delegate = self;

    [User getFrequentDrivers:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get frequent drivers FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent drivers");
            
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
    // 初始化UIRefreshControl
    // rc为该控件的一个指针，只能用于表视图界面
    // 关于布局问题可以不用考虑，关于UITableViewController会将其自动放置于表视图中
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]init];
    // 一定要注意selector里面的拼写检查
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = rc;
    [self.table addSubview:self.refreshControl];
}

- (void) refreshTableView
{
    if (self.refreshControl.refreshing) {// 判断是否处于刷新状态
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] init];
        [User getFrequentDrivers:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get frequent drivers FAILED!!!!");
            }else{
                NSLog(@"Now getting frequent drivers");
                
                self.freqDriverList = user.freqDriverList;
                [self.table reloadData];    
            }
        }];
        
        [self.refreshControl endRefreshing];

    }
    
}


-(void)viewDidAppear:(BOOL)animated
{
    if ([self.refreshStat isEqualToString:@"refresh"]) {
        [User getFrequentDrivers:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get frequent drivers FAILED!!!!");
            }else{
                NSLog(@"Now getting frequent drivers");
            
                self.freqDriverList = user.freqDriverList;
                //weakSelf.billList = user.billList;
                //[weakSelf.billTable reloadData];
                [self.table reloadData];
                //int count=0;
                //            for(Bill* b in weakSelf.billList){
                //                NSLog(@"%d %@",count++,b.contents);
                //            }
                self.refreshStat = @"notRefresh";
            
            }
        }];
    
    }
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
    subDriverDtl.id = driverItem.id;
    [self.navigationController pushViewController:subDriverDtl animated:YES];
    //返回时取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        
        
        NSInteger rowNo = indexPath.row;
        
        
        Driver *driverItem = [self.freqDriverList objectAtIndex:rowNo];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除司机" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [User deleteFrequentDriver:driverItem.id withBlock:^(NSError *error, User *user) {
                if(error){
                    NSLog(@"Delete Driver FAILED!!!!");
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除司机失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }else{
                    
                    
                    
                    NSLog(@"Delete Driver succeed");
                    
                    [self.freqDriverList removeObjectAtIndex:rowNo];
                    
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除司机成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        
                        
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
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end