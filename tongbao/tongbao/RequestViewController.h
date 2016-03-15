//
//  RequestViewController.h
//  tongbao
//
//  Created by ZX on 16/2/27.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestViewController : UITableViewController

@property (strong,nonatomic) NSString* fromAddr;
@property (strong,nonatomic) NSString* toAddr;
@property (strong,nonatomic) NSString* carType;

@end