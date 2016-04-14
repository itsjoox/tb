//
//  SubEvaluateOrderViewController.m
//  tongbao
//
//  Created by ZX on 16/4/6.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubEvaluateOrderViewController.h"
#import "User.h"
#import "Order.h"
#import "NearbyViewController.h"
#import "Truck.h"
#import "CWStarRateView.h"
#import "HomeViewController.h"

@interface SubEvaluateOrderViewController ()
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UITableViewCell *pointCell;
@property (strong, nonatomic) IBOutlet UITextView *commentTxtView;
@property (strong, nonatomic) CWStarRateView *starRateView;
@end

@implementation SubEvaluateOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.table.delegate = self;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(125, 10, 150, 20) numberOfStars:5];
    self.starRateView.scorePercent = 1;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    [self.pointCell addSubview:self.starRateView];
    self.table.delegate = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSInteger rowNo = indexPath.row;
    if (indexPath.section==2) {
        
        Comment* comment = [[Comment alloc]init];
        comment.id = self.orderId;
        NSNumber* pt = [NSNumber numberWithInt: self.starRateView.scorePercent*5];
        comment.evaluatePoint = [pt stringValue];
        NSLog(comment.evaluatePoint);
        comment.evaluateContent = self.commentTxtView.text;
        
        
        [User evaluateOrder: comment withBlock:^(NSError *error, User *user)
         {
             
             if (error) {
                 NSLog(@"evaluate Order FAILED!!!!");
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评价失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                 [alertController addAction:okAction];
                 [self presentViewController:alertController animated:YES completion:nil];
             }else{
                 //self.myNickname.text = new.text;
                 NSLog(@"evaluate Order SUCCESSFULLY!");
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评价成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     HomeViewController *setHomeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
                     
                     //使用popToViewController返回并传值到上一页面
                     [self.navigationController popToViewController:setHomeVC animated:true];
                 }];
                 [alertController addAction:okAction];
                 [self presentViewController:alertController animated:YES completion:nil];
             }
         }];
        }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end