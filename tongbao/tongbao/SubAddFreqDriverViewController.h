//
//  SubAddFreqDriverViewController.h
//  tongbao
//
//  Created by ZX on 16/3/28.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubAddFreqDriverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSArray* drivers;

@end