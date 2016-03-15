//
//  User.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**
 *  Single Instance of User
 *
 *  @return user
 */
+ (instancetype)currentUser;


/**
 *  username
 */

@property (copy, nonatomic, readonly) NSString *username;

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

@end