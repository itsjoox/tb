//
//  SubMessageViewController.h
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubMessageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSArray* msgs;
@property (strong, nonatomic) NSArray* dtls;

@end

