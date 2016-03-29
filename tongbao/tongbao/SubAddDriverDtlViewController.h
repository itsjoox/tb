//
//  SubAddDriverDtlViewController.h
//  tongbao
//
//  Created by ZX on 16/3/28.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Driver.h"
@interface SubAddDriverDtlViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *driverTelLbl;

@property (strong, nonatomic) IBOutlet UITextField *driverNameLbl;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* tel;
@property (strong, nonatomic) Driver* driver;



@end
