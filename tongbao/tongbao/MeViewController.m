//
//  MeViewController.m
//  tongbao
//
//  Created by ZX on 16/2/21.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "MeViewController.h"
#import "SubAboutViewController.h"
#import "User.h"

@interface MeViewController ()



@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.table.delegate = self;
    self.nickname.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    self.telephone.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [self setHeadPortrait];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger rowNo = indexPath.row;
    NSInteger sectionNo = indexPath.section;
    
    if (sectionNo == 3 && rowNo == 0){
        NSLog(@"log out");
        //获取UserDefaults单例
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //移除UserDefaults中存储的用户信息
        [userDefaults removeObjectForKey:@"username"];
        [userDefaults removeObjectForKey:@"token"];
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

//  设置头像样式
-(void)setHeadPortrait{
    //    NSLog(@"设置头像！！ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]);
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]){
        [self.myHeadportrait setImage: [User getImageFromURL: [[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]]];
    }
    //    //  把头像设置成圆形
    //    self.myHeadPortrait.layer.cornerRadius=self.myHeadPortrait.frame.size.width/2;
    //    self.myHeadPortrait.layer.masksToBounds=YES;
    //    //  给头像加一个圆形边框
    //    self.myHeadPortrait.layer.borderWidth = 1.5f;
    //    self.myHeadPortrait.layer.borderColor = [UIColor whiteColor].CGColor;
}




@end