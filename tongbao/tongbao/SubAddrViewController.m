//
//  SubAddrViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubAddrViewController.h"
#import "SubEditFreqAddrViewController.h"
#import "User.h"
#import "Address.h"



@interface SubAddrViewController ()

@end

@implementation SubAddrViewController

@synthesize addrs;
@synthesize dtls;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    dtls = [NSArray arrayWithObjects:@"", @"厢式货车", @"大卡车", nil];
    addrs = [NSArray arrayWithObjects:@"南京市鼓楼区汉口路22号", @"南京市鼓楼区广州路3号", @"南京市玄武区珠江路18号", nil];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.freqAddrList = [[NSMutableArray alloc]init];
    
    [User getFrequentAddresses:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get frequent addresses FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
           
            self.freqAddrList = user.freqAddrList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
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
        [User getFrequentAddresses:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get frequent addresses FAILED!!!!");
            }else{
                NSLog(@"Now getting frequent addresses");
                
                self.freqAddrList = user.freqAddrList;
                //weakSelf.billList = user.billList;
                //[weakSelf.billTable reloadData];
                [self.table reloadData];
            }
        }];

        [self.refreshControl endRefreshing];
        //[self.table reloadData];
    }
    
}





-(void)viewDidAppear:(BOOL)animated
{
    if ([self.refreshStat isEqualToString:@"refresh"]) {
     
        [User getFrequentAddresses:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get frequent addresses FAILED!!!!");
            }else{
                NSLog(@"Now getting frequent addresses");
            
                self.freqAddrList = user.freqAddrList;
                //weakSelf.billList = user.billList;
                //[weakSelf.billTable reloadData];
                [self.table reloadData];
            
                self.refreshStat = @"notRefresh";
            }
        }];
        
    }

}




- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
     Address* addr = [self.freqAddrList objectAtIndex:rowNo];
    
    // 获取cell内包含的Tag为1的UILabel
    UILabel* addrLbl = (UILabel*)[cell viewWithTag:1];
    addrLbl.text =addr.name;
    UILabel* contactNameLbl = (UILabel*)[cell viewWithTag:2];
    contactNameLbl.text =addr.contactName;
    UILabel* contactPhoneLbl = (UILabel*)[cell viewWithTag:3];
    contactPhoneLbl.text =addr.contactPhone;
    
    
    return cell;
     
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.freqAddrList.count;
    
}


- (IBAction)fromHere:(id)sender {
}

- (IBAction)toHere:(id)sender {
}

//可用segue方法
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"seg1"]) //"goView2"是SEGUE连线的标识
//            {
//                 NSLog(@"in");
//             //NSLog(segue.destinationViewController);
//                 id destController = segue.destinationViewController;
//                 //id dest = segue.destinationViewController;
//                 // 使用KVC方式将label内的文本设为destController的editContent属性值
//                
//                 [destController setValue:@"here" forKey:@"address"];
//             }
//
//
//            NSLog(@"here");
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    

    SubEditFreqAddrViewController* subEditFreqAddr = [self.storyboard instantiateViewControllerWithIdentifier: @"SubEditFreqAddr"];
    Address* addr = [self.freqAddrList objectAtIndex:rowNo];
    subEditFreqAddr.myAddr = addr;
    subEditFreqAddr.address = addr.name;
    //NSLog(@"%@", subEditFreqAddr.address);
    [self.navigationController pushViewController:subEditFreqAddr animated:YES];
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
        
        Address* addr = [self.freqAddrList objectAtIndex:rowNo];

        
       
                    
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除常用地址" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [User deleteFrequentAddress:addr.id withBlock:^(NSError *error, User *user) {
                if(error){
                    NSLog(@"Delete Order FAILED!!!!");
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除常用地址失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }else{
                    
                    
                    
                    NSLog(@"Delete Order succeed");
                    
                    [self.freqAddrList removeObjectAtIndex:rowNo];
                    
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除常用地址成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
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