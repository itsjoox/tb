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
    
    
    [User getMyMessages:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get Messages FAILED!!!!");
        }else{
            NSLog(@"Now getting msgs");
            
            for (int i=0; i<msgList.count; i++) {
                Message* msgItem = [msgList objectAtIndex:i];
                if ([msgItem.type isEqualToString:@"订单被抢到"]||[msgItem.type isEqualToString:@"其他消息"]) {
                    [self.msgList addObject:[msgList objectAtIndex:i]];
                }
            }
            
            
            self.msgList = user.msgList;
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
    
    UITextView* contentTxtView = (UITextView*)[cell viewWithTag:4];
    contentTxtView.text = msgItem.content;
    
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
    subMsgDtl.myOrderNo = msgItem.id;
    [self.navigationController pushViewController:subMsgDtl animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end