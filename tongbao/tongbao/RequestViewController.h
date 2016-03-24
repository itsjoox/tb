//
//  RequestViewController.h
//  tongbao
//
//  Created by ZX on 16/2/27.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RequestViewController : UITableViewController<UITableViewDelegate>

@property (strong,nonatomic) CLPlacemark* srcAddrPlsmk;
@property (strong,nonatomic) CLPlacemark* destAddrPlsmk;
@property (strong,nonatomic) NSString* carType;

@end