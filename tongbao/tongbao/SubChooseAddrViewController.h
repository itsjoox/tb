//
//  SubChooseAddr.h
//  tongbao
//
//  Created by ZX on 16/2/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SubChooseAddrViewController : UITableViewController<UITableViewDelegate>

@property (nonatomic, copy) CLPlacemark* placemark;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UITextView *addr;
@property (strong, nonatomic) IBOutlet UITableView *table;


@end