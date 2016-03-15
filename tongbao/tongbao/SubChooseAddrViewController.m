//
//  SubChooseAddr.m
//  tongbao
//
//  Created by ZX on 16/2/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubChooseAddrViewController.h"
#import "RequestViewController.h"
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSInteger rowNo = indexPath.row;
    if (indexPath.section==2) {
        RequestViewController *setRequest = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
        //初始化其属性
        //setPrizeVC. = nil;
        
        //传递参数过去
        if (indexPath.row==0) {
            setRequest.srcAddrPlsmk = self.placemark;
        }else{
            setRequest.destAddrPlsmk = self.placemark;
            
        }
        //使用popToViewController返回并传值到上一页面
        [self.navigationController popToViewController:setRequest animated:true];
        //
        //        [self.navigationController pushViewController:subMsgDtl animated:YES];
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end