//
//  User.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Order.h"

@interface User : NSObject

/**
 *  Single Instance of User
 *
 *  @return us
 */
+ (instancetype)currentUser;


/**
 *  username： in our case, it's 电话号码
 */

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic) NSString *nickname;

@property (copy, nonatomic) NSString *iconUrl;
@property (copy, nonatomic) NSString *point;
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic, readonly) NSString *token;


/**
 *  Judge whether user has login
 *
 *  @return whether user has login
 */
+ (BOOL)hasLogin;


/**
 *  login method
 *
 *  @param stuId          stuID
 *  @param password       password
 *  @param completedBlock complete block
 */
+ (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password withBlock:(void (^)(NSError *error, User *user))completedBlock;

/**
* register method
 
*
 
*/

+(void) registerwithUsername: (NSString *)username andPassoword: (NSString *) password withBlock:(void (^)(NSError *error, User *user))completedBlock;

+(void) modifyNickname: (NSString *)newName withBlock:(void (^)(NSError *error, User *user))completedBlock;
+(void) uploadImage: (UIImage *)newHead withBlock:(void (^)(NSError *error, User *user))completedBlock;
+(void) modifyHeadportrait: (NSString *)newUrl withBlock:(void (^)(NSError *error, User *user))completedBlock;

+(void) withdrawMoney: (NSInteger) money withBlock:(void (^)(NSError *error, User *user))completedBlock;
+(void) rechargeMoney: (NSInteger) money withBlock:(void (^)(NSError *error, User *user))completedBlock;
+(void) showBills:(void (^)(NSError *error, User *user))completedBlock;


+ (UIImage *) getImageFromURL:(NSString *)fileURL;

+(void) placeOrder: (Order*) order withBlock:(void (^)(NSError *error, User *user))completedBlock;
@end