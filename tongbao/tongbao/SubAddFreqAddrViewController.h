//
//  SubAddFreqAddrViewController.h
//  tongbao
//
//  Created by ZX on 16/3/25.
//  Copyright © 2016年 ZX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SubAddFreqAddrViewController : UITableViewController<UITableViewDelegate>
@property (strong,nonatomic) CLPlacemark* freqAddrPlsmk;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end