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
#import "JPUSHService.h"

@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userpwdTextfield;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [JPUSHService startLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [JPUSHService stopLogPageView:@"PageOne"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img_m = [UIImage imageNamed:@"tongbao"];   
    self.view.layer.contents = (id)img_m.CGImage;
//    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;

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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];

        }else {
//            用模态跳转到主界面
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    id homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabView"];
                    [self presentViewController:homeViewController animated:YES completion:^{
                }];

        }
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernameTextfield resignFirstResponder];
    [self.userpwdTextfield resignFirstResponder];
}
    

@end

