//
//  MeViewController.m
//  tongbao
//
//  Created by ZX on 16/2/21.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "MeViewController.h"
#import "SubAboutViewController.h"

@interface MeViewController ()


@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.table.delegate = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    //NSInteger rowNo = indexPath.row;
    if (section==3) {
        NSLog(@"hi");
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end