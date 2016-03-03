//
//  SubChooseAddr.m
//  tongbao
//
//  Created by ZX on 16/2/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubChooseAddrViewController.h"

@interface SubChooseAddrViewController ()

@end

@implementation SubChooseAddrViewController


- (void)viewDidLoad {
    [super viewDidLoad];
      
    self.name.text = self.placemark.name;
   
//    CLPlacemark* pl = self.placemark;
//    NSLog([[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%@,%@,%@", pl.country,pl.locality,pl.subLocality,pl.thoroughfare,pl.subThoroughfare,pl.administrativeArea,pl.subAdministrativeArea]);
//   
    
    NSArray* addrArray = self.placemark
    .addressDictionary[@"FormattedAddressLines"];
    // 将详细地址拼接成一个字符串
    NSMutableString* address = [[NSMutableString alloc] init];
    for(int i = 0 ; i < addrArray.count ; i ++)
    {
        [address appendString:addrArray[i]];
    }
    
    self.addr.text = address;
   
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end