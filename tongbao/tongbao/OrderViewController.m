//
//  OrderViewController.m
//  tongbao
//
//  Created by ZX on 16/2/21.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "OrderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "confirmedOrder.h"

@interface OrderViewController ()

@property (strong, nonatomic) NSArray* tbl;
@property (strong, nonatomic) NSString* cellIdentifier;
@property (strong, nonatomic) NSString* orderState;

@end


@implementation OrderViewController

@synthesize waitingOrderList;
@synthesize deliveringOrderList;
@synthesize finishedOrderList;
@synthesize canceledOrderList;

@synthesize tbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.view.backgroundColor = UIColor.whiteColor;

    
    self.table.dataSource = self;
    self.table.delegate = self;

    
    [User showMyOrderList:@"0" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get waitingOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting waitingOrderList");
            
            self.waitingOrderList = user.waitingOrderList;
            self.tbl = self.waitingOrderList;
            
            [self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"1" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get deliveringOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting deliveringOrderList");
            
            self.deliveringOrderList = user.deliveringOrderList;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"2" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get finishedOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting finishedOrderList");
            
            self.finishedOrderList = user.finishedOrderList;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"3" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get canceledOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting canceledOrderList");
            
            self.canceledOrderList = user.canceledOrderList;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    
    
    self.cellIdentifier = @"cell1";
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"订单列表" style:UIBarButtonItemStylePlain target:nil action:nil];
    
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
        
        [User showMyOrderList:@"0" withBlock:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get waitingOrderList FAILED!!!!");
            }else{
                NSLog(@"Now getting waitingOrderList");
                
                self.waitingOrderList = user.waitingOrderList;
//                self.tbl = self.waitingOrderList;
//                
//                [self.table reloadData];
                
            }
        }];
        
        [User showMyOrderList:@"1" withBlock:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get deliveringOrderList FAILED!!!!");
            }else{
                NSLog(@"Now getting deliveringOrderList");
                
                self.deliveringOrderList = user.deliveringOrderList;
                //self.tbl = self.waitingOrderList;
                
                // [self.table reloadData];
                
            }
        }];
        
        [User showMyOrderList:@"2" withBlock:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get finishedOrderList FAILED!!!!");
            }else{
                NSLog(@"Now getting finishedOrderList");
                
                self.finishedOrderList = user.finishedOrderList;
                //self.tbl = self.waitingOrderList;
                
                // [self.table reloadData];
                
            }
        }];
        
        [User showMyOrderList:@"3" withBlock:^(NSError *error, User *user) {
            if(error){
                NSLog(@"Get canceledOrderList FAILED!!!!");
            }else{
                NSLog(@"Now getting canceledOrderList");
                
                self.canceledOrderList = user.canceledOrderList;
                //self.tbl = self.waitingOrderList;
                
                // [self.table reloadData];
                
            }
        }];
        if ([self.orderState isEqualToString:@"waiting"]) {
            NSLog(@"refreshWaiting");
            self.tbl = self.waitingOrderList;
            
            [self.table reloadData];
        }else if ([self.orderState isEqualToString:@"delivering"]) {
            NSLog(@"refreshDelivering");
            self.tbl = self.deliveringOrderList;
            
            [self.table reloadData];
        }else if ([self.orderState isEqualToString:@"finished"]) {
            NSLog(@"refreshFinished");
            self.tbl = self.finishedOrderList;
            
            [self.table reloadData];
        }else if ([self.orderState isEqualToString:@"canceled"]) {
            NSLog(@"refreshCanceled");
            self.tbl = self.canceledOrderList;
            
            [self.table reloadData];
        }
        [self.refreshControl endRefreshing];
        //[self.table reloadData];
    }
    
}

-(void) viewWillAppear:(BOOL)animated{
    if ([self.refreshStat isEqualToString:@"refresh"]) {
    
    [User showMyOrderList:@"0" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get waitingOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting waitingOrderList");
            
            self.waitingOrderList = user.waitingOrderList;
            //self.tbl = self.waitingOrderList;

            //[self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"1" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get deliveringOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting deliveringOrderList");
            
            self.deliveringOrderList = user.deliveringOrderList;
            //self.tbl = self.waitingOrderList;
            
           // [self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"2" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get finishedOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting finishedOrderList");
            
            self.finishedOrderList = user.finishedOrderList;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    
    [User showMyOrderList:@"3" withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get canceledOrderList FAILED!!!!");
        }else{
            NSLog(@"Now getting canceledOrderList");
            
            self.canceledOrderList = user.canceledOrderList;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    self.refreshStat = @"notRefresh";
    
    }
}

-(void) viewDidAppear:(BOOL)animated{
    if ([self.orderState isEqualToString:@"waiting"]) {
       
        self.tbl = self.waitingOrderList;
        
        [self.table reloadData];
    }else if ([self.orderState isEqualToString:@"delivering"]) {
       
        self.tbl = self.deliveringOrderList;
        
        [self.table reloadData];
    }else if ([self.orderState isEqualToString:@"finished"]) {
        self.tbl = self.finishedOrderList;
        
        [self.table reloadData];
    }else if ([self.orderState isEqualToString:@"canceled"]) {
        
        self.tbl = self.canceledOrderList;
        
        [self.table reloadData];
    }
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    
    // 根据identifier获取表格行（self.identifier要么是cell1，要么是cell2）
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             self.cellIdentifier forIndexPath:indexPath];
   
    confirmedOrder *cfOrderItem = [[confirmedOrder alloc]init];
    cfOrderItem= [self.tbl objectAtIndex:rowNo];
    // 获取cell内包含的Tag为1的UILabel
    UILabel* idLbl = (UILabel*)[cell viewWithTag:1];
    
    //idLbl.text = [self.tbl objectAtIndex:rowNo];
    idLbl.text = [cfOrderItem.id stringValue];
    
    UILabel* fromAddrLbl = (UILabel*)[cell viewWithTag:2];
    
    //idLbl.text = [self.tbl objectAtIndex:rowNo];
    fromAddrLbl.text = cfOrderItem.addressFrom;
    
    UILabel* toAddrLbl = (UILabel*)[cell viewWithTag:3];
    
    //idLbl.text = [self.tbl objectAtIndex:rowNo];
    toAddrLbl.text = cfOrderItem.addressTo;
    
    
    UILabel* priceLbl = (UILabel*)[cell viewWithTag:4];
    
    //idLbl.text = [self.tbl objectAtIndex:rowNo];
    priceLbl.text = [cfOrderItem.money stringValue];
    
    UILabel* timeLbl = (UILabel*)[cell viewWithTag:5];
    
    //idLbl.text = [self.tbl objectAtIndex:rowNo];
    timeLbl.text = cfOrderItem.time;
    
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    return tbl.count;
}



- (IBAction)orderState:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            
            
            NSLog(@"0");
            self.tbl = self.waitingOrderList;
            NSLog(@"%@",self.waitingOrderList);
            
            self.orderState = @"waiting";
            self.cellIdentifier = @"cell1";
            [self.table reloadData];
            break;
            
        case 1:
            
              NSLog(@"1");
            
            
            self.tbl = self.deliveringOrderList;
            self.orderState = @"delivering";
             self.cellIdentifier = @"cell2";
            
            NSLog(@"%@",self.deliveringOrderList);
            
            [self.table reloadData];
            break;
       
            
        case 2:
              NSLog(@"2");
           
            self.tbl = self.finishedOrderList;
             NSLog(@"%@",self.finishedOrderList);
            
            self.orderState = @"finished";
             self.cellIdentifier = @"cell3";
            [self.table reloadData];
            
             break;
            
        case 3:
            NSLog(@"3");
            
            self.tbl = self.canceledOrderList;
            NSLog(@"%@",self.canceledOrderList);
            
            self.orderState = @"canceled";
            self.cellIdentifier = @"cell3";
            [self.table reloadData];
            
            break;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    
    SubOrderDtlViewController* subOrderDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubOrderDtl"];
    confirmedOrder *cfOrderItem = [[confirmedOrder alloc]init];
    cfOrderItem= [self.tbl objectAtIndex:rowNo];
    
    subOrderDtl.myOrderID = [cfOrderItem.id stringValue];
    subOrderDtl.myOrderState = self.orderState;
    subOrderDtl.cfOrderItem = cfOrderItem;
    
    [User getOrderDetail:[cfOrderItem.id stringValue] withBlock:^(NSError *error, confirmedOrder *cfOrderItm) {
        if(error){
            NSLog(@"Get orderList FAILED!!!!");
        }else{
            NSLog(@"Now getting orderList");
            
             confirmedOrder* myCfOrderItem = cfOrderItem;
            //self.tbl = self.waitingOrderList;
            
            // [self.table reloadData];
            
        }
    }];
    
    
    [self.navigationController pushViewController:subOrderDtl animated:YES];

    //返回时取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end