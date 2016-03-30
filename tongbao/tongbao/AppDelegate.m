//
//  AppDelegate.m
//  tongbao
//
//  Created by ZX on 16/2/16.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "AppDelegate.h"

#import "OrderViewController.h"
#import "User.h"
#import "JPUSHService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
    
    [[NSBundle mainBundle] loadNibNamed:@"JpushTabBarViewController"
                                  owner:self
                                options:nil];
    
    // Override point for customization after application launch.
    
    //判断是否登陆，由登陆状态判断启动页面
    //获取UserDefault
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"username"];
    NSString *password = [userDefault objectForKey:@"password"];

    //获取storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //如果用户未登陆则把根视图控制器改变成登陆视图控制器
    if (username == nil || username.length == 0||password == nil || password.length == 0)
    {
        NSLog(@"还没有登录哦%@",username);
        id view = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        self.window.rootViewController = view;
    } else{
         NSLog(@"登陆过啦 直接登录咯 %@ %@",username,password);
        [User loginWithUsername:username andPassword:[userDefault objectForKey:@"password"]  withBlock:^(NSError *error, User *user) {
            if (error) {
                NSLog(@"LOGIN FAILED!!!!");
            }else {
                NSLog(@"LOGIN SUCCESSFULLY!!!!");
            }
        }];

    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    // Required
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    
}


@end
