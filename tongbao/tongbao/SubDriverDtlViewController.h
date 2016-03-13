//
//  SubDriverDtlViewController.h
//  tongbao
//
//  Created by ZX on 16/2/28.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SubDriverDtlViewController : UITableViewController

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* tel;

@property (strong, nonatomic) IBOutlet UITextField *driverTel;
@property (strong, nonatomic) IBOutlet UITextField *driverName;


@end