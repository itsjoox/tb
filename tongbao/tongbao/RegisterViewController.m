//
//  RegisterViewController.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"


@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *userpwdTextfield;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TapRegister:(UIButton *)sender {
    NSString * username = self.usernameTextfield.text;
    NSString * userpwd = self.userpwdTextfield.text;
    
//    if ([User registerwithUsername:username andPassoword:userpwd]) {
//        // if register successfully then give a hint and then login
//        
////        hint and load
//        
////        login
//        if([User loginWithUsername:username andPassword:userpwd]){
//           
//            //用模态跳转到主界面 same as what in loginviewcontroller
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//            id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
//            [self presentViewController:homeViewController animated:YES completion:^{
//            }];
//
//        }
//    }
    
    [User registerwithUsername:username andPassoword:userpwd withBlock:^(NSError *error, User *user) {
        if (error) {
            NSLog(@"Register FAILED!!!!");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请重新输入用户名和密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else {
            NSLog(@"注册过啦 直接登录咯 %@ %@",username,userpwd);
            [User loginWithUsername:username andPassword:userpwd withBlock:^(NSError *error, User *user) {
                if (error) {
                    NSLog(@"LOGIN FAILED!!!!");
                }else {
                    NSLog(@"LOGIN SUCCESSFULLY!!!!");
                    //用模态跳转到主界面 same as what in loginviewcontroller
                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
                    [self presentViewController:homeViewController animated:YES completion:^{
                        }];
                }
            }];
       
        }

    }];
    
    
}




@end