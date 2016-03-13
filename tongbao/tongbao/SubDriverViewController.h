//
//  SubDriverViewController.h
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDriverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSArray* drivers;
@property (strong, nonatomic) NSArray* dtls;

@end