//
//  SubAddFreqAddrViewController.m
//  tongbao
//
//  Created by ZX on 16/3/25.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "SubAddFreqAddrViewController.h"
#import "SubAddrViewController.h"
#import "NearbyViewController.h"
#import "User.h"
#import "Address.h"

@interface SubAddFreqAddrViewController ()

@property (strong, nonatomic) IBOutlet UITextField *addr;
@property (strong, nonatomic) IBOutlet UITextField *contact;
@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) NSString *callerName;
@property (strong, nonatomic) Address *addrItem;

@end

@implementation SubAddFreqAddrViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addrItem = [[Address alloc] init];
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
    
    self.addrItem.name = freqAddress;
    
    NSLog(freqAddress);
    
    NSNumber* latNum =  [NSNumber numberWithDouble:self.freqAddrPlsmk.location.coordinate.latitude];
    NSNumber* lngNum =  [NSNumber numberWithDouble:self.freqAddrPlsmk.location.coordinate.longitude];
    self.addrItem.lat = [latNum stringValue];
    self.addrItem.lng = [lngNum stringValue];
    
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
        
        self.addrItem.contactName = self.contact.text;
        self.addrItem.contactPhone = self.tel.text;
        
        if ([self.addrItem.name isEqual:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择常用地址" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        else if ([self.addrItem.contactName isEqual:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请添加收货人姓名" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }else if ([self.addrItem.contactPhone isEqual:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请添加收货人电话" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }else{
            [User addFrequentAddress: self.addrItem withBlock:^(NSError *error, User *user)
             {
                 
                 if (error) {
                     NSLog(@"ADD FREQADDR FAILED!!!!");
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                     [alertController addAction:okAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }else{
                     //self.myNickname.text = new.text;
                     NSLog(@"ADD FREQADDR SUCCESSFULLY!");
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                         SubAddrViewController *setsubAddrVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                         
                         //使用popToViewController返回并传值到上一页面
                         [self.navigationController popToViewController:setsubAddrVC animated:true];
                     }];
                     [alertController addAction:okAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                }
             }];

        }
        
        
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
