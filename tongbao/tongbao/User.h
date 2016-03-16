//
//  User.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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
@property (copy, nonatomic, readonly) NSString *nickname;

@property (copy, nonatomic, readonly) NSString *iconUrl;
@property (copy, nonatomic, readonly) NSString *point;
@property (copy, nonatomic, readonly) NSString *money;
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
+ (BOOL)loginWithUsername:(NSString *)username andPassword:(NSString *)password;

/**
* register method
 
*
 
*/

+(BOOL) registerwithUsername: (NSString *)username andPassoword: (NSString *) password;
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
@end