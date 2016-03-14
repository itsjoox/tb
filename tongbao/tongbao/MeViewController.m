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
    
    NSInteger rowNo = indexPath.row;
    NSInteger sectionNo = indexPath.section;
    
    if (sectionNo == 3 && rowNo == 0){
        NSLog(@"log out");
        //获取UserDefaults单例
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //移除UserDefaults中存储的用户信息
        [userDefaults removeObjectForKey:@"name"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults synchronize];
        //获取storyboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        //获取注销后要跳转的页面
        id view = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        //模态展示出登陆页面
        [self presentViewController:view animated:YES completion:^{
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end