//
//  SubDriverViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubDriverViewController.h"
#import "SubDriverDtlViewController.h"

@interface SubDriverViewController ()

@end

@implementation SubDriverViewController

@synthesize drivers;
@synthesize dtls;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    drivers = [NSArray arrayWithObjects:@"李华", @"赵红梅", @"王磊", nil];
    dtls = [NSArray arrayWithObjects:@"18951997878", @"13645361336", @"18997783231", nil];
    self.table.dataSource = self;
    self.table.delegate = self;

}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    // 根据行号的奇偶性使用不同的标识符
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    // 获取cell内包含的Tag为1的UILabel
    UILabel* label1 = (UILabel*)[cell viewWithTag:1];
    label1.text = [drivers objectAtIndex:rowNo];
    
    UILabel* label2 = (UILabel*)[cell viewWithTag:2];
    label2.text = [dtls objectAtIndex:rowNo];
    
    
    return cell;

    
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
    return drivers.count;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubDriverDtlViewController* subDriverDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubDriverDtl"];

    subDriverDtl.name = [drivers objectAtIndex:rowNo];
    subDriverDtl.tel = [dtls objectAtIndex:rowNo];
  
    [self.navigationController pushViewController:subDriverDtl animated:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end