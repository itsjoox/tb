//
//  SubChooseCarViewController.h
//  tongbao
//
//  Created by ZX on 16/2/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubChooseCarViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)doneSelectedTruck:(id)sender;

@property (strong, nonatomic) NSArray* truckList;
@property (strong, nonatomic) NSMutableArray* selectedTruckList;

@end