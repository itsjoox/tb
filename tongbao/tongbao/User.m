//
//  User.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "User.h"
#import "AFNetworking.h"
#import "NSError+custom.h"


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
            sharedInstance.user = [[User alloc] initWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] andNickname:nil andHeadPortrait:nil andToken:nil];
        }
    });
    return sharedInstance;
}

+ (instancetype)currentUser
{
    return [User shareInstance].user;
}


- (instancetype)initWithUsername:(NSString *)username andNickname: (NSString *) nickname andHeadPortrait: (NSString *) iconUrl andToken: (NSString *) token
{
    self = [super init];
    if (self) {
        _username = username;
        _nickname = nickname;
        _iconUrl = iconUrl;
        _token = token;
        }
    return self;
}



+(void) registerwithUsername: (NSString *)username andPassoword: (NSString *) password withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (username == nil || username.length == 0 || password == nil || password.length == 0) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    } else{
        
        //请求的参数
        NSDictionary *parameters = @{@"phoneNumber":username,
                                     @"password":password,
                                     @"type":@0
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/register";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        //请求的方式：POST



        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"请求成功啦 注册结果 %@",responseObject[@"result"]);
                    NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                [User shareInstance].user = [[User alloc] initWithUsername:username andNickname:nil andHeadPortrait:nil andToken:nil];
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:responseObject[@"errorMsg"]], [User shareInstance].user);
                }
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError * error) {
                        NSLog(@"请求失败,服务器返回的错误信息%@",error);
            //            NSLog(@"登录失败");
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];

    }

}



+(void) loginWithUsername:(NSString *)username andPassword:(NSString *)password withBlock:(void (^)(NSError *error, User *user))completedBlock{
        if (username == nil || username.length == 0 || password == nil || password.length == 0) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
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
            NSLog(@"登录成功啦 %@",responseObject[@"result"]);
            
            NSDictionary *responseDic = (NSDictionary *)responseObject[@"data"];
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                
                [User shareInstance].user = [[User alloc] initWithUsername:username andNickname:responseDic[@"nickName"] andHeadPortrait:responseDic[@"iconUrl"] andToken:responseDic[@"token"]];
                
                NSLog(@"user.m 头像地址！！ %@",responseDic[@"iconUrl"]);
                NSLog(@"user.m nickName！！ %@",responseDic[@"nickName"]);
                
                [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"iconUrl"] forKey:@"headPortrait"];
                [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"nickName"] forKey:@"nickname"];
                [[NSUserDefaults standardUserDefaults] setObject:responseDic[@"token"] forKey:@"token"];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"newLogin"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            } else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }

            }
            
        } failure:^(NSURLSessionDataTask *task, NSError * error) {
//            NSLog(@"请求失败,服务器返回的错误信息%@",error);
//            NSLog(@"登录失败");
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
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