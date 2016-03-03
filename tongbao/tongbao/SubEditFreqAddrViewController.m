//
//  SubEditFrqViewController.m
//  tongbao
//
//  Created by ZX on 16/2/28.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubEditFreqAddrViewController.h"

@interface SubEditFreqAddrViewController ()

@property (strong, nonatomic) IBOutlet UITextField *addr;
@property (strong, nonatomic) IBOutlet UITextField *contact;
@property (strong, nonatomic) IBOutlet UITextField *tel;

@end

@implementation SubEditFreqAddrViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.addr.text = self.address;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
