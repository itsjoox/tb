//
//  User.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "User.h"
#import "AFNetworking.h"


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
            sharedInstance.user = [[User alloc] initWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] andNickname:nil andHeadPortrait:nil];
        }
    });
    return sharedInstance;
}

+ (instancetype)currentUser
{
    return [User shareInstance].user;
}


- (instancetype)initWithUsername:(NSString *)username andNickname: (NSString *) nickname andHeadPortrait: (NSString *) iconUrl
{
    self = [super init];
    if (self) {
        _username = username;
        _nickname = nickname;
        _iconUrl = iconUrl;
        }
    return self;
}



+(BOOL) registerwithUsername: (NSString *)username andPassoword: (NSString *) password{
    if (username == nil || username.length == 0 || password == nil || password.length == 0) {
        return NO;
    } else{
        
        
        
        
        return YES;
    }
    
    return NO;
}



+(BOOL) loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    if (username == nil || username.length == 0 || password == nil || password.length == 0) {
        return NO;
    } else {

        //请求的参数
        NSDictionary *parameters = @{@"phoneNumber":username,
                                     @"password":password,
                                     @"type":@0
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/login";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        //请求的方式：POST
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"请求成功，服务器返回的信息%@",responseObject);
            NSDictionary *responseDic = (NSDictionary *)responseObject[@"data"];
            [User shareInstance].user = [[User alloc] initWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] andNickname:responseDic[@"nickName"] andHeadPortrait:responseDic[@"iconUrl"]];

//            NSLog(@"user.m 头像地址！！ %@",responseDic[@"iconUrl"]);
//            NSLog(@"user.m 昵称！！ %@",responseDic[@"nickName"]);

            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"iconUrl"] forKey:@"headPortrait"];
            [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"nickName"] forKey:@"nickname"];

            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"newLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } failure:^(NSURLSessionDataTask *task, NSError * error) {
//            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            NSLog(@"登录失败");
        }];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] length] > 0){
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

+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"downloading image");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}  


@end