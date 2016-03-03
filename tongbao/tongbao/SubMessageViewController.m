//
//  SubMessageViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubMessageViewController.h"
#import "SubMsgDtlViewController.h"

@interface SubMessageViewController ()

@end

@implementation SubMessageViewController

@synthesize msgs;
@synthesize dtls;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    msgs = [NSArray arrayWithObjects:@"开始送货", @"已抢单", @"已取消抢单", nil];
    
    dtls = [NSArray arrayWithObjects:@"2016/2/21 12:00", @"2016/2/21 08:50", @"2016/2/21 07:00", nil];
    
    self.table.dataSource = self;
    self.table.delegate = self;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger rowNo = indexPath.row;  // 获取行号
    NSString* identifier = @"cell1";
    
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    
    
    // 获取cell内包含的Tag为1的UILabel
    UILabel* label1 = (UILabel*)[cell viewWithTag:2];
    label1.text = [msgs objectAtIndex:rowNo];
    
    UILabel* label2 = (UILabel*)[cell viewWithTag:3];
    label2.text = [dtls objectAtIndex:rowNo];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
        return msgs.count;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubMsgDtlViewController* subMsgDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubMsgDtl"];
    
    subMsgDtl.myMsgTitle = [msgs objectAtIndex:rowNo];
    subMsgDtl.myMsgDtl = [dtls objectAtIndex:rowNo];
    
    [self.navigationController pushViewController:subMsgDtl animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end