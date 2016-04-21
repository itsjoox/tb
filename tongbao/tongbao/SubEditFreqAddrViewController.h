//
//  SubEditFreqViewController.h
//  tongbao
//
//  Created by ZX on 16/2/28.
//  Copyright © 2016年 ZX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Address.h"
@interface SubEditFreqAddrViewController : UITableViewController<UITableViewDelegate>
@property (strong,nonatomic) CLPlacemark* freqAddrPlsmk;
@property (strong, nonatomic) Address* myAddr;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end