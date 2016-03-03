//
//  SubChooseCarViewController.h
//  tongbao
//
//  Created by ZX on 16/2/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubChooseCarViewController : UIViewController<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSArray* cars;
@property (strong, nonatomic) NSArray* dtls;

@end