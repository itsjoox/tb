//
//  SubAddFreqAddrViewController.m
//  tongbao
//
//  Created by ZX on 16/3/25.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubAddFreqAddrViewController.h"
#import "NearbyViewController.h"
@interface SubAddFreqAddrViewController ()

@property (strong, nonatomic) IBOutlet UITextField *addr;
@property (strong, nonatomic) IBOutlet UITextField *contact;
@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) NSString *callerName;

@end

@implementation SubAddFreqAddrViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.addr.text = self.address;
    self.table.delegate = self;
    self.callerName = @"SubAddFreqAddrViewController";
}

-(void)viewDidAppear:(BOOL)animated
{
    NSArray* freqAddrArray = self.freqAddrPlsmk
    .addressDictionary[@"FormattedAddressLines"];
    // 将详细地址拼接成一个字符串
    NSMutableString* freqAddress = [[NSMutableString alloc] init];
    for(int i = 0 ; i < freqAddrArray.count ; i ++)
    {
        [freqAddress appendString:freqAddrArray[i]];
    }
    
    
    
    self.addr.text = freqAddress;
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger rowNo = indexPath.row;
    if (section == 0) {
        if (rowNo == 0) {
            NearbyViewController* nearbyVC = [self.storyboard instantiateViewControllerWithIdentifier: @"Nearby"];
            
            nearbyVC.caller = self.callerName;
            [self.navigationController pushViewController:nearbyVC animated:YES];
        }
    }else if (section == 1){
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
