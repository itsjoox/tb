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
#import "Bill.h"
#import "Message.h"
#import "Address.h"
#import "Driver.h"
#import "Truck.h"
#import "confirmedOrder.h"

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

- (NSMutableArray *)billList
{
    if (!_billList) _billList = [[NSMutableArray alloc] init];
    return _billList;
}

- (NSMutableArray *)msgList
{
    if (!_msgList) _msgList = [[NSMutableArray alloc] init];
    return _msgList;
}


- (NSMutableArray *)freqAddrList
{
    if (!_freqAddrList) _freqAddrList = [[NSMutableArray alloc] init];
    return _freqAddrList;
}

- (NSMutableArray *)freqDriverList
{
    if (!_freqDriverList) _freqDriverList = [[NSMutableArray alloc] init];
    return _freqDriverList;
}

- (NSMutableArray *)driverList
{
    if (!_driverList) _driverList = [[NSMutableArray alloc] init];
    return _driverList;
}

- (NSMutableArray *)truckList
{
    if (!_truckList) _truckList = [[NSMutableArray alloc] init];
    return _truckList;
}

- (NSMutableArray *)waitingOrderList
{
    if (!_waitingOrderList) _waitingOrderList = [[NSMutableArray alloc] init];
    return _waitingOrderList;
}

- (NSMutableArray *)deliveringOrderList
{
    if (!_deliveringOrderList) _deliveringOrderList = [[NSMutableArray alloc] init];
    return _deliveringOrderList;
}

- (NSMutableArray *)finishedOrderList
{
    if (!_finishedOrderList) _finishedOrderList = [[NSMutableArray alloc] init];
    return _finishedOrderList;
}

- (NSMutableArray *)canceledOrderList
{
    if (!_canceledOrderList) _canceledOrderList = [[NSMutableArray alloc] init];
    return _canceledOrderList;
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

+(void) modifyNickname: (NSString *)newName withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (newName == nil || newName.length == 0 ) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"nickName":newName
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/modifyNickName";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                [User shareInstance].user.nickname = newName;
                [[NSUserDefaults standardUserDefaults] setObject:newName forKey:@"nickname"];

                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }

        }failure:^(NSURLSessionDataTask *task, NSError * error) {
             NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
   
}

+(void) uploadImage: (UIImage *)newHead withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (newHead == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
         NSData *data = UIImagePNGRepresentation(newHead);
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/uploadPicture";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSData *data = UIImageJPEGRepresentation(newHead,0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
           formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"上传图片连接成功啦 %@ 图片地址 %@",responseObject[@"result"],responseObject[@"data"]);
            NSString * result = responseObject[@"result"];
                        if ([result intValue] == 1){
                            [User shareInstance].user.iconUrl = responseObject[@"data"][@"url"];
                            if (completedBlock) {
                                completedBlock(nil, [User shareInstance].user);
                            }
                        }else{
                            if (completedBlock) {
                                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                            }
                        }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                            }
        }];
    }
    
}




+(void) modifyHeadportrait: (NSString *)newUrl withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (newUrl == nil || newUrl.length == 0 ) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"iconUrl":newUrl
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/modifyIcon";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"修改头像连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                [User shareInstance].user.iconUrl = newUrl;
                [[NSUserDefaults standardUserDefaults] setObject:newUrl forKey:@"headPortrait"];

                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
    
}


+(void) withdrawMoney: (NSInteger) money withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if(money < 0){
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"money": @(money),
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/withdraw";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"提现连接成功啦 %@",responseObject[@"result"]);
//            NSLog(@"error message %@",responseObject[@"errorMsg"]);

            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                NSLog(@"提现成功啦 %@",responseObject[@"result"]);                
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];

    }
}

+(void) rechargeMoney: (NSInteger) money withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if(money < 0){
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"money": @(money),
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/recharge";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"充值连接成功啦 %@",responseObject[@"result"]);
//            NSLog(@"error message %@",responseObject[@"errorMsg"]);
            
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                NSLog(@"充值成功啦 %@",responseObject[@"result"]);
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }

}

+(void) showBills:(void (^)(NSError *error, User *user))completedBlock{
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                 };
    //请求的url
    NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/showAccount";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"查看账单连接成功啦 %@",responseObject[@"result"]);
        NSArray* resultArray = responseObject[@"data"];
        [[User shareInstance].user.billList removeAllObjects];
//        NSLog(@"账单如下 %@",resultArray);
        for (NSDictionary *dic in resultArray) {
//            NSLog(@"value: %@", [dic objectForKey:@"type"]);
            NSLog(@"账单如下 %@",dic);
            Bill* test = [[Bill alloc] init];
            test.type = [Bill getType:[dic objectForKey:@"type"]];
            test.time = [dic objectForKey:@"time"];
            test.money = [[dic objectForKey:@"money"] stringValue];
            [[User shareInstance].user.billList addObject:test];
        }
       

        //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
        
        NSString * result = responseObject[@"result"];
        if ([result intValue] == 1){
            NSLog(@"查看成功啦 %@",responseObject[@"result"]);
            
            if (completedBlock) {
                completedBlock(nil, [User shareInstance].user);
            }
        }else{
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
        }
    }];

    
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




/**
 * functions add by ZX
 *
 */

+(void) getMyMessages:(void (^)(NSError *error, User *user))completedBlock{
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                 };
    //请求的url
    NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/auth/getMyMessages";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取消息连接成功啦 %@",responseObject[@"result"]);
        NSArray* resultArray = responseObject[@"data"];
        [[User shareInstance].user.msgList removeAllObjects];
        
        for (NSDictionary *dic in resultArray) {
            //            NSLog(@"value: %@", [dic objectForKey:@"type"]);
            NSLog(@"消息如下 %@",dic);
            Message* msg = [[Message alloc] init];
            msg.id = [dic objectForKey:@"id"];
            msg.type = [Message getType:[dic objectForKey:@"type"]];
            NSInteger type = [[dic objectForKey:@"type"]integerValue];
            msg.content = [dic objectForKey:@"content"];
            msg.hasRead = [Message getReadStatus:[dic objectForKey:@"hasRead"]];
            msg.time =[dic objectForKey:@"time"];
            if (type==0||type==1||type==2) {
                msg.objectId = [dic objectForKey:@"objectId"];
            }
            
            
//            Bill* test = [[Bill alloc] init];
//            test.type = [Bill getType:[dic objectForKey:@"type"]];
//            test.time = [dic objectForKey:@"time"];
//            test.money = [[dic objectForKey:@"money"] stringValue];
            
            [[User shareInstance].user.msgList addObject:msg];
        }
        
        
        //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
        
        NSString * result = responseObject[@"result"];
        if ([result intValue] == 1){
            NSLog(@"查看成功啦 %@",responseObject[@"result"]);
            
            if (completedBlock) {
                completedBlock(nil, [User shareInstance].user);
            }
        }else{
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
        }
    }];
    

}




+(void) getFrequentAddresses:(void (^)(NSError *error, User *user))completedBlock{
    
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                 };
    //请求的url
    NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/getFrequentAddresses";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取常用地址连接成功啦 %@",responseObject[@"result"]);
        NSArray* resultArray = responseObject[@"data"];
        [[User shareInstance].user.freqAddrList removeAllObjects];
        
        for (NSDictionary *dic in resultArray) {
            //            NSLog(@"value: %@", [dic objectForKey:@"type"]);
            NSLog(@"地址如下 %@",dic);
            Address* addr = [[Address alloc] init];
            
            //
        
            addr.name = [dic objectForKey:@"name"];
        
            
            addr.lat = [dic objectForKey:@"lat"];
            
            addr.lng =[dic objectForKey:@"lng"];
            
            [[User shareInstance].user.freqAddrList addObject:addr];
        }
        
        
        //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
        
        NSString * result = responseObject[@"result"];
        if ([result intValue] == 1){
            NSLog(@"查看成功啦 %@",responseObject[@"result"]);
            
            if (completedBlock) {
                completedBlock(nil, [User shareInstance].user);
            }
        }else{
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
        }
    }];
    
    
    
    
}

+(void) addFrequentAddress: (Address*) address withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (address == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"lat":address.lat,
                                     @"address":address.name,
                                     @"lng":address.lng,
                                    
                                     };
        
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/addFrequentAddress";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                
                NSLog(@"添加地址成功");
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    NSLog(@"添加地址失败");
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
}



+(void) placeOrder: (Order*) order withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (order == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
   
        NSMutableString *str = [[NSMutableString alloc]init];
        [str appendString:@"["];
        for (int i=0; i<order.truckTypes.count-1; i++) {
            Truck* truckItem = [order.truckTypes objectAtIndex:i];
            //NSLog(@"%lu", (unsigned long)truckItem.type);
            //NSString* s = [];
            [str appendString:[truckItem.type stringValue]];
            [str appendString:@","];
        }
        
        Truck* truckItem = [order.truckTypes objectAtIndex:order.truckTypes.count-1];
        [str appendString:[truckItem.type stringValue]];
        [str appendString:@"]"];
        //str = [NSMutableString stringWithString:@"[1,2]"];
        NSLog(str);
        
        //NSMutableString *str = [NSMutableString stringWithString:@"[1,2]"];
        
        //NSDictionary这种初始化方式不能有nil
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"addressFrom":order.addressFrom,
                                     @"addressFromLat":order.addressFromLat,
                                     @"addressFromLng":order.addressFromLng,
                                     @"addressTo":order.addressTo,
                                     @"addressToLat":order.addressToLat,
                                     @"addressToLng":order.addressToLng,
                                     @"fromContactName":order.fromContactName,
                                     @"fromContactPhone":order.fromContactPhone,
                                     @"toContactName":order.toContactName,
                                     @"toContactPhone":order.toContactPhone,
                                     @"loadTime":order.loadTime,
                                     @"goodsType":order.goodsType,
                                     @"goodsWeight":order.goodsWeight,
                                     @"goodsSize":order.goodsSize,
                                     @"truckTypes":str,
                                     @"remark":order.remark,
                                     @"payType":@"1",
                                     @"price":order.price,
                                     @"distance":order.distance,
                                     };

        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/placeOrder";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
//        managers.requestSerializer =[AFJSONRequestSerializer serializer];
//        managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
//        NSString *post = [NSString stringWithFormat:@"http://120.27.112.9:8080/tongbao/shipper/auth/placeOrder?token=%@&addressFrom=%@&addressFromLat=%@&addressFromLng=%@&addressTo=%@&addressToLat=%@&addressToLng=%@&fromContactName=%@&fromContactPhone=%@&toContactName=%@&toContactPhone=%@&loadTime=%@&goodsType=%@&goodsWeight=%d&goodsSize=%d&truckTypes=%@&remark=%@&payType=%d&price=%d", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"2016-11-09 00:00:00",@"0",1,1,@"[1]",@"0",1,8];
        
//        
//        NSString *utf = [post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
         [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            //NSLog(@"下单失败 %@",responseObject[@"errorMsg"]);
            if ([result intValue] == 1){
                
                NSLog(@"下单成功");
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else if([result intValue] == 2){
                NSLog(@"没有合适司机，分割订单");
                
            }else{
                if (completedBlock) {
                   
                   
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
         

        
        
    }
         
    
}


+(void) searchDriver: (NSString *) phoneNum withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (phoneNum == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
     
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"], @"phoneNum":phoneNum
                                     };
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/searchDriver";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"搜索司机连接成功啦 %@",responseObject[@"result"]);
            NSArray* resultArray = responseObject[@"data"];
            [[User shareInstance].user.driverList removeAllObjects];
            
            for (NSDictionary *dic in resultArray) {
                //            NSLog(@"value: %@", [dic objectForKey:@"type"]);
                NSLog(@"地址如下 %@",dic);
                Driver* driver = [[Driver alloc] init];
                
                //
                
                driver.id = [dic objectForKey:@"id"];
                
                if ([[dic objectForKey:@"nickName"] isEqual:[NSNull null]]) {
                    driver.nickName = @"无名氏";
                }else{
                   driver.nickName = [dic objectForKey:@"nickName"];
                }
                
                
                driver.phoneNum =[dic objectForKey:@"phoneNum"];
                
                [[User shareInstance].user.driverList addObject:driver];
            }
            
            
            //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
            
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                NSLog(@"搜索成功啦 %@",responseObject[@"result"]);
                
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
    
    
    
}


+(void) addFrequentDriver: (Driver*) driver withBlock:(void (^)(NSError *error, User *user))completedBlock{
    if (driver == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"id":driver.id
                                     };
        
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/addFrequentDriver";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                
                NSLog(@"添加司机成功");
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    NSLog(@"添加司机失败");
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
}


+(void) getFrequentDrivers:(void (^)(NSError *error, User *user))completedBlock{
    
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                 };
    //请求的url
    NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/getFrequentDrivers";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"获取常用司机连接成功啦 %@",responseObject[@"result"]);
        
        NSArray* resultArray = responseObject[@"data"];
        
        [[User shareInstance].user.freqDriverList removeAllObjects];
        
        for (NSDictionary *dic in resultArray) {
            //            NSLog(@"value: %@", [dic objectForKey:@"type"]);
            NSLog(@"司机如下 %@",dic);
            Driver* driverItem = [[Driver alloc] init];

            driverItem.id = [dic objectForKey:@"id"];
          
            driverItem.nickName = [dic objectForKey:@"nickName"]; 
            driverItem.phoneNum =[dic objectForKey:@"phoneNum"];
            
            [[User shareInstance].user.freqDriverList addObject:driverItem];
        }
        
        
        //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
        
        NSString * result = responseObject[@"result"];
        if ([result intValue] == 1){
            NSLog(@"查看成功啦 %@",responseObject[@"result"]);
            
            if (completedBlock) {
                completedBlock(nil, [User shareInstance].user);
            }
        }else{
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
        }
    }];
    
}

+(void) getAllTruckTypes:(void (^)(NSError *error, User *user))completedBlock{
    
    NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                 };
    //请求的url
    NSString *urlString = @"http://120.27.112.9:8080/tongbao/user/getAllTruckTypes";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"获取货车类型连接成功啦 %@",responseObject[@"result"]);
        NSArray* resultArray = responseObject[@"data"];
        
        [[User shareInstance].user.truckList removeAllObjects];
        
        
        for (NSDictionary *dic in resultArray) {
            NSLog(@"货车如下 %@",dic);
            Truck* truckItem = [[Truck alloc] init];
            
            truckItem.type = [dic valueForKey:@"type"];
            truckItem.name = [dic valueForKey:@"name"];
            truckItem.basePrice =[dic valueForKey:@"basePrice"];
            truckItem.capacity = [dic valueForKey:@"capacity"];
            truckItem.length = [dic valueForKey:@"length"];
            truckItem.width = [dic valueForKey:@"width"];
            truckItem.height = [dic valueForKey:@"height"];
            truckItem.overPrice = [dic valueForKey:@"overPrice"];
            truckItem.baseDistance = [dic valueForKey:@"baseDistance"];
            
            
            [[User shareInstance].user.truckList addObject:truckItem];
        }
        
        
        //            NSLog(@"error message %@",responseObject[@"errorMsg"]);
        
        NSString * result = responseObject[@"result"];
        if ([result intValue] == 1){
            NSLog(@"查看成功啦 %@",responseObject[@"result"]);
            if (completedBlock) {
                completedBlock(nil, [User shareInstance].user);
            }
            
        }else{
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
        }
    }];
    
}


+(void) showMyOrderList:(NSString *)type withBlock:(void (^)(NSError *, User *))completedBlock{
    if (type == nil) {
        if (completedBlock) {
            completedBlock([NSError errorWithCode:ErrorCodeIncomplete andDescription:nil], nil);
        }
    }else{
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"type":type
                                     };
        
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/showMyOrderList";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
           
            
            NSArray* resultArray = responseObject[@"data"];
            
            if ([type isEqualToString:@"0"]) {
                [[User shareInstance].user.waitingOrderList removeAllObjects];
            }else if ([type isEqualToString:@"1"]) {
                [[User shareInstance].user.deliveringOrderList removeAllObjects];
            }else if ([type isEqualToString:@"2"]) {
                [[User shareInstance].user.finishedOrderList removeAllObjects];
            }else if ([type isEqualToString:@"3"]) {
                [[User shareInstance].user.canceledOrderList removeAllObjects];
            }
            
            //[[User shareInstance].user.truckList removeAllObjects];
            
            
            for (NSDictionary *dic in resultArray) {
                NSLog(@"订单如下 %@",dic);
                confirmedOrder* cfOrderItem = [[confirmedOrder alloc] init];
                
                cfOrderItem.id = [dic valueForKey:@"id"];
                cfOrderItem.time = [dic valueForKey:@"time"];
                cfOrderItem.addressFrom =[dic valueForKey:@"addressFrom"];
                cfOrderItem.addressTo =[dic valueForKey:@"addressTo"];
                cfOrderItem.money =[dic valueForKey:@"money"];
                cfOrderItem.truckTypes =[dic valueForKey:@"truckTypes"];
                cfOrderItem.fromContactName =[dic valueForKey:@"fromContactName"];
                cfOrderItem.fromContactPhone =[dic valueForKey:@"fromContactPhone"];
                cfOrderItem.toContactName =[dic valueForKey:@"toContactName"];
                cfOrderItem.toContactPhone =[dic valueForKey:@"toContactPhone"];
                cfOrderItem.loadTime =[dic valueForKey:@"loadTime"];
                
                if ([type isEqualToString:@"0"]) {
                    [[User shareInstance].user.waitingOrderList addObject:cfOrderItem];
                }else if ([type isEqualToString:@"1"]) {
                    [[User shareInstance].user.deliveringOrderList addObject:cfOrderItem];
                }else if ([type isEqualToString:@"2"]) {
                    [[User shareInstance].user.finishedOrderList addObject:cfOrderItem];
                }else if ([type isEqualToString:@"3"]) {
                    [[User shareInstance].user.canceledOrderList addObject:cfOrderItem];
                }
                
            }
            
             NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                
                NSLog(@"查看订单成功");
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else{
                if (completedBlock) {
                    NSLog(@"查看订单失败");
                    completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError * error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
            if (completedBlock) {
                completedBlock([NSError errorWithCode:ErrorCodeAuthenticateError andDescription:nil], [User shareInstance].user);
            }
        }];
        
    }
}

@end