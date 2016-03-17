//
//  MeViewController.h
//  tongbao
//
//  Created by ZX on 16/2/21.
//  Copyright © 2016年 ZX. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MeViewController : UITableViewController<UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *myHeadportrait;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *telephone;

@end