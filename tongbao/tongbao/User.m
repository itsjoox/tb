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
        //部分改为int
        //        NSString* addressFrom = [orderDetail objectForKey:@"addressFrom"];
        //        NSString* addressFromLat = [orderDetail objectForKey:@"addressFromLat"];
        //        NSString* addressFromLng = [orderDetail objectForKey:@"addressFromLng"];
        //        NSString* addressTo = [orderDetail objectForKey:@"addressTo"];
        //        NSString* addressToLat = [orderDetail objectForKey:@"addressToLat"];
        //        NSString* addressToLng = [orderDetail objectForKey:@"addressToLng"];
        //        NSString* fromContactName = [orderDetail objectForKey:@"fromContactName"];
        //        NSString* fromContactPhone = [orderDetail objectForKey:@"fromContactPhone"];
        //        NSString* toContactName = [orderDetail objectForKey:@"toContactName"];
        //        NSString* toContactPhone = [orderDetail objectForKey:@"toContactPhone"];
        //        NSString* loadTime = [orderDetail objectForKey:@"loadTime"];
        //        NSString* goodsType = [orderDetail objectForKey:@"goodsType"];
        //        NSString* goodsWeight = [orderDetail objectForKey:@"goodsWeight"];
        //        NSString* goodsSize = [orderDetail objectForKey:@"goodsSize"];
        //        NSString* truckTypes = [orderDetail objectForKey:@"truckTypes"];
        //        NSString* remark = [orderDetail objectForKey:@"remark"];
        //        NSString* payType = [orderDetail objectForKey:@"payType"];
        //        NSString* price = [orderDetail objectForKey:@"price"];
        
        
        
        //NSDictionary这种初始化方式不能有nil
        //第一个没登陆为空。。会出错
        NSDictionary *parameters = @{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],
                                     @"addressFrom":order.addressFrom,
                                     @"addressFromLat":order.addressFromLat,
                                     @"addressFromLng":order.addressFromLng,
                                     @"addressTo":order.addressTo,
                                     @"adressToLat":order.addressToLat,
                                     @"adressToLng":order.addressToLng,
                                     @"fromContactName":order.fromContactName,
                                     @"fromContactPhone":order.fromContactPhone,
                                     @"toContactName":order.toContactName,
                                     @"toContactPhone":order.toContactPhone,
                                     @"loadTime":order.loadTime,
                                     @"goodsType":order.goodsType,
                                     @"goodsWeight":order.goodsWeight,
                                     @"goodsSize":order.goodsSize,
                                     @"truckTypes":order.truckTypes,
                                     @"remark":order.remark,
                                     @"payType":order.payType,
                                     @"price":order.price
                                     };
        
        //请求的url
        NSString *urlString = @"http://120.27.112.9:8080/tongbao/shipper/auth/placeOrder";
        //请求的managers
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        
        [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"连接成功啦 %@",responseObject[@"result"]);
            NSString * result = responseObject[@"result"];
            if ([result intValue] == 1){
                
                NSLog(@"下单成功");
                if (completedBlock) {
                    completedBlock(nil, [User shareInstance].user);
                }
            }else if([result intValue] == 2){
                NSLog(@"没有合适司机，分割订单");
                
            }else{
                if (completedBlock) {
                    NSLog(@"下单失败");
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