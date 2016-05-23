//
//  SubMessageViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubMessageViewController.h"
#import "SubMsgDtlViewController.h"
#import "User.h"
#import "Message.h"

@interface SubMessageViewController ()


@end

@implementation SubMessageViewController

@synthesize msgList;
@synthesize dtls;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    //msgs = [NSArray arrayWithObjects:@"开始送货", @"已抢单", @"已取消抢单", nil];
    
    //dtls = [NSArray arrayWithObjects:@"2016/2/21 12:00", @"2016/2/21 08:50", @"2016/2/21 07:00", nil];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.msgList = [[NSMutableArray alloc] init];
    
//    [User getMyMessages:^(NSError *error, User *user) {
//        if(error){
//            NSLog(@"Get Messages FAILED!!!!");
//        }else{
//            NSLog(@"Now getting msgs");
//            [self.msgList removeAllObjects];
//            
//            for (int i=0; i<user.msgList.count; i++) {
//                Message* msgItem = [user.msgList objectAtIndex:i];
//                
//                
//                if ([msgItem.type isEqualToString:@"订单被抢到"]||[msgItem.type isEqualToString:@"其他消息"]) {
//                    [self.msgList addObject:[user.msgList objectAtIndex:i]];
//                }
//            }
//            
//            
//            //self.msgList = user.msgList;
//            //weakSelf.billList = user.billList;
//            //[weakSelf.billTable reloadData];
//            [self.table reloadData];
//            
//            
//        }
//    }];
    
    Message* msgItem0 = [[Message alloc]init];
    msgItem0.id= @"a10544";
    msgItem0.type = @"订单被抢到";
    msgItem0.content = @"您的订单191已被司机李伟抢到";
    msgItem0.hasRead = @"0";
    msgItem0.time = @"2016-05-01 07:12:31";
    msgItem0.objectId = @"191";
    [self.msgList addObject:msgItem0];
//    NSLog(@"here");
//    NSLog(@"%@",self.msgList);
    
    Message* msgItem1 = [[Message alloc]init];
    msgItem1.id= @"a10536";
    msgItem1.type = @"订单派送中";
    msgItem1.content = @"您的订单183正在派送中";
    msgItem1.hasRead = @"0";
    msgItem1.time = @"2016-04-23 10:17:34";
    msgItem1.objectId = @"183";
    [self.msgList addObject:msgItem1];
    
    
    Message* msgItem2 = [[Message alloc]init];
    msgItem2.id= @"a10531";
    msgItem2.type = @"订单被抢到";
    msgItem2.content = @"您的订单183已被司机李伟抢到";
    msgItem2.hasRead = @"0";
    msgItem2.time = @"2016-04-22 15:34:11";
    msgItem2.objectId = @"183";
    [self.msgList addObject:msgItem2];
    
    
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger rowNo = indexPath.row;  // 获取行号
    NSString* identifier = @"cell1";
    
   
    
    
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    
    Message* msgItem = [msgList objectAtIndex:rowNo];
    // 获取cell内包含的Tag为 的UILabel
    
    
    UILabel* shortTitleLbl = (UILabel*)[cell viewWithTag:2];
    shortTitleLbl.text = msgItem.type;
    
    UILabel* timeLbl = (UILabel*)[cell viewWithTag:3];
    timeLbl.text = msgItem.time;
    
    UILabel* contentLbl = (UILabel*)[cell viewWithTag:4];
    contentLbl.text = msgItem.content;
    
    return cell;
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
        return msgList.count;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubMsgDtlViewController* subMsgDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubMsgDtl"];
    Message* msgItem = [self.msgList objectAtIndex:rowNo];
    //subMsgDtl.myMsgTitle = [msgs objectAtIndex:rowNo];
    subMsgDtl.myMsgDtl = msgItem.content;
    subMsgDtl.myMsgTitle = msgItem.type;
    subMsgDtl.myOrderNo = msgItem.objectId;
    [self.navigationController pushViewController:subMsgDtl animated:YES];
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
   
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除消息" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end