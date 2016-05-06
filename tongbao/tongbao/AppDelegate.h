//
//  AppDelegate.h
//  tongbao
//
//  Created by ZX on 16/2/16.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderViewController;
static NSString *appKey = @"ca9fe909612197690db46060";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) OrderViewController *orderViewControler;


@end

