//
//  WalletViewController.h
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bill.h"

@interface WalletViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate>


- (IBAction)recharge:(UIButton *)sender;

- (IBAction)withdraw:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITableView *billTable;

@property (strong, nonatomic) NSArray *billList;

@end