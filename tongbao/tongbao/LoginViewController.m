//
//  LoginViewController.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/9.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "AFNetworking.h"

@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userpwdTextfield;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TapLogin:(UIButton *)sender {
    [User loginWithUsername:self.usernameTextfield.text andPassword:self.userpwdTextfield.text  withBlock:^(NSError *error, User *user) {
        if (error) {
            NSLog(@"LOGIN FAILED!!!!");
        }else {
//            用模态跳转到主界面
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
                    [self presentViewController:homeViewController animated:YES completion:^{
                }];

        }
    }];
    
//    if ([User loginWithUsername:self.usernameTextfield.text andPassword:self.userpwdTextfield.text]){
//        //用模态跳转到主界面
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
//        [self presentViewController:homeViewController animated:YES completion:^{
//        }];
//    }
    
        
//    //获取用户输入的信息
//    NSString *username = self.usernameTextfield.text;
//    NSString *password = self.userpwdTextfield.text;
//    NSString *usernameTarget = @"admin";
//    NSString *passwordTarget = @"admin";
//    
//    //对用户信息的验证
//    if ([username isEqualToString: usernameTarget]&& [password isEqualToString:passwordTarget]){
//        //获取userDefault单例
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        //登陆成功后把用户名和密码存储到UserDefault
//        [userDefaults setObject:username forKey:@"username"];
//        [userDefaults setObject:password forKey:@"password"];
//        [userDefaults synchronize];
//        //用模态跳转到主界面
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
//        [self presentViewController:homeViewController animated:YES completion:^{
//        }];
//    }
}



@end

