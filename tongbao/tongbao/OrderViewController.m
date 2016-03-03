//
//  OrderViewController.m
//  tongbao
//
//  Created by ZX on 16/2/21.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "OrderViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface OrderViewController ()

@property (strong, nonatomic) NSArray* tbl;
@property (strong, nonatomic) NSString* cellIdentifier;
@property (strong, nonatomic) NSString* orderState;

@end


@implementation OrderViewController

@synthesize orders;
@synthesize details;
@synthesize tbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.view.backgroundColor = UIColor.whiteColor;
    
    orders = [NSArray arrayWithObjects:@"160612334", @"134522332", nil];
    details = [NSArray arrayWithObjects:@"1321434", @"214324", nil];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.tbl = orders;
    self.cellIdentifier = @"cell1";
}



- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    
    // 根据identifier获取表格行（self.identifier要么是cell1，要么是cell2）
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             self.cellIdentifier forIndexPath:indexPath];
    // 获取cell内包含的Tag为1的UILabel
    UILabel* label = (UILabel*)[cell viewWithTag:1];
    label.text = [self.tbl objectAtIndex:rowNo];
    return cell;
    
}


-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return tbl.count;
}



- (IBAction)orderState:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            
            self.tbl = orders;
            self.orderState = @"waiting";
            self.cellIdentifier = @"cell1";
            [self.table reloadData];
            break;
        case 1:
            
            self.tbl = self.details;
            self.orderState = @"now";
             self.cellIdentifier = @"cell2";
            [self.table reloadData];
            break;
       
            
        default:
            self.orderState = @"finished";
             self.cellIdentifier = @"cell3";
            [self.table reloadData];
            break;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubOrderDtlViewController* subOrderDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubOrderDtl"];
    
    subOrderDtl.myOrderNo = [self.tbl objectAtIndex:rowNo];
    subOrderDtl.myOrderState = self.orderState;
    
    [self.navigationController pushViewController:subOrderDtl animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end