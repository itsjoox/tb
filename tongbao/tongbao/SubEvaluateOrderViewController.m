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

@interface SubEvaluateOrderViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *pointCell;
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end