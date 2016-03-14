//
//  User.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "User.h"


@interface User ()

@property (strong, nonatomic) User *user;

@end


@implementation User

+ (instancetype)shareInstance
{
    static User *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[User alloc] init];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] length] > 0) {
            sharedInstance.user = [[User alloc] initWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
        }
    });
    return sharedInstance;
}

+ (instancetype)currentUser
{
    return [User shareInstance].user;
}


- (instancetype)initWithUsername:(NSString *)username
{
    self = [super init];
    if (self) {
        _username = username;
        }
    return self;
}


+(BOOL) loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    if (username == nil || username.length == 0 || password == nil || password.length == 0) {
        return NO;
    } else {
           
            NSString *usernameTarget = @"admin";
            NSString *passwordTarget = @"admin";
        
            //对用户信息的验证
            if ([username isEqualToString: usernameTarget]&& [password isEqualToString:passwordTarget]){
                //获取userDefault单例
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                //登陆成功后把用户名和密码存储到UserDefault
                [userDefaults setObject:username forKey:@"username"];
                [userDefaults setObject:password forKey:@"password"];
                [userDefaults synchronize];
                return YES;
           }
    }
    return NO;
}

+ (BOOL)hasLogin
{
    return [User currentUser] != nil;
}

- (User *)user
{
    if ([User shareInstance] == self) {
        return _user;
    }
    return nil;
}


@end