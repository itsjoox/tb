//
//  RequestViewController.m
//  tongbao
//
//  Created by ZX on 16/2/27.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "RequestViewController.h"
#import "User.h"
#import "Order.h"
#import "NearbyViewController.h"
#import "Truck.h"
#import "HomeViewController.h"
@interface RequestViewController ()


- (IBAction)payTypeSwitch:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *useTimeTxtFld;

- (IBAction)useTime:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *srcAddrTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *destAddrTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *carTypeTxtFld;
@property (strong, nonatomic) IBOutlet UILabel *distLbl;
@property (strong, nonatomic) IBOutlet UITextField *senderNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *senderTelTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *recevierTelTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *receiverNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *cargoTypeTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *cargoWeightTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *cargoVolumeTxtFld;
@property (strong, nonatomic) IBOutlet UILabel *moneyLbl;


@property (strong, nonatomic) IBOutlet UITextView *psTxtView;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong , nonatomic) NSString* payType;

@end

@implementation RequestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.delegate = self;
    self.selectedTruckList = [[NSArray alloc]init];
}


//处理次级页面传来的信息
-(void)viewDidAppear:(BOOL)animated
{
    NSArray* srcAddrArray = self.srcAddrPlsmk
    .addressDictionary[@"FormattedAddressLines"];
    // 将详细地址拼接成一个字符串
    NSMutableString* srcAddress = [[NSMutableString alloc] init];
    for(int i = 0 ; i < srcAddrArray.count ; i ++)
    {
        [srcAddress appendString:srcAddrArray[i]];
    }
    NSArray* destAddrArray = self.destAddrPlsmk
    .addressDictionary[@"FormattedAddressLines"];
    // 将详细地址拼接成一个字符串
    NSMutableString* destAddress = [[NSMutableString alloc] init];
    for(int i = 0 ; i < destAddrArray.count ; i ++)
    {
        [destAddress appendString:destAddrArray[i]];
    }
   
    
    //显示选中货车种类
    NSMutableString *carType =[[NSMutableString alloc] init];
    
    if(self.selectedTruckList.count>0){
        
        for(int i = 0 ; i < self.selectedTruckList.count-1 ; i ++)
        {
            Truck *truckItem = [self.selectedTruckList objectAtIndex:i];
            [carType appendString:truckItem.name];
            [carType appendString:@","];
        }
        Truck *truckItem = [self.selectedTruckList objectAtIndex:self.selectedTruckList.count-1 ];
        [carType appendString:truckItem.name];
    }
    
    
    
    self.srcAddrTxtFld.text = srcAddress;
    self.destAddrTxtFld.text = destAddress;
    self.carTypeTxtFld.text = carType;

    
    
    
    
    //计算两点导航距离
    MKPlacemark* srcPlsmk = [[MKPlacemark alloc] initWithPlacemark:self.srcAddrPlsmk];
    MKMapItem *mapItemSrc = [[MKMapItem alloc] initWithPlacemark:srcPlsmk];
    MKPlacemark* destPlsmk = [[MKPlacemark alloc] initWithPlacemark:self.destAddrPlsmk];
    MKMapItem *mapItemDest = [[MKMapItem alloc] initWithPlacemark:destPlsmk];
    
    [mapItemSrc setName:@"name1"];
    [mapItemDest setName:@"name2"];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:mapItemSrc];
    [request setDestination:mapItemDest];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle Error
         } else {
             
             
            CLLocationDistance dist = [response.routes firstObject].distance;
             NSLog(@"src to dest %f km",dist/1000);
             self.distLbl.text = [NSString stringWithFormat:@"%.f",dist/1000];
         }
     }];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)useTime:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    //选中某个时出发chooseDate方法
    [picker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    //设置datepicker显示日期和时间
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    [alertController.view addSubview:picker];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
        }];
        action;
    })];
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    popoverController.sourceView = sender;
    popoverController.sourceRect = [sender bounds];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}

//转换成用户用车时间并显示
- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.useTimeTxtFld.text = dateString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger rowNo = indexPath.row;
    if (section==0) {
        if (rowNo==0) {
            NearbyViewController* nearbyVC = [self.storyboard instantiateViewControllerWithIdentifier: @"Nearby"];
            
            nearbyVC.caller = @"srcAddr";
            [self.navigationController pushViewController:nearbyVC animated:YES];
        }
    }else if (section==1){
        if (rowNo==0) {
            NearbyViewController* nearbyVC = [self.storyboard instantiateViewControllerWithIdentifier: @"Nearby"];
            
            nearbyVC.caller = @"destAddr";
            [self.navigationController pushViewController:nearbyVC animated:YES];
        }
    }else if (section==6) {
        
        NSString* srcAddr = self.srcAddrTxtFld.text;
        
        NSNumber *srcAddrLatinDouble = [NSNumber numberWithDouble:self.srcAddrPlsmk.location.coordinate.latitude];
        NSString* srcAddrLat = [srcAddrLatinDouble stringValue];
        NSNumber *srcAddrLnginDouble = [NSNumber numberWithDouble:self.srcAddrPlsmk.location.coordinate.longitude];
        NSString* srcAddrLng = [srcAddrLnginDouble stringValue];
        
        NSString* destAddr = self.destAddrTxtFld.text;
        NSNumber *destAddrLatinDouble = [NSNumber numberWithDouble:self.destAddrPlsmk.location.coordinate.latitude];
        NSString* destAddrLat = [destAddrLatinDouble stringValue];
        NSNumber *destAddrLnginDouble = [NSNumber numberWithDouble:self.destAddrPlsmk.location.coordinate.longitude];
        NSString* destAddrLng = [destAddrLnginDouble stringValue];
        
        NSString* fromContactName = self.senderNameTxtFld.text;
        NSString* fromContactPhone = self.senderTelTxtFld.text;
        
        NSString* toContactName = self.receiverNameTxtFld.text;
        NSString* toContactPhone = self.recevierTelTxtFld.text;
       
        NSString* loadTime = self.useTimeTxtFld.text;
        NSString* goodsType = self.cargoTypeTxtFld.text;
        NSString* goodsWeight = self.cargoWeightTxtFld.text;
        NSString* goodsSize = self.cargoVolumeTxtFld.text;
        NSArray* truckTypes = self.selectedTruckList;
        NSString* remark = self.psTxtView.text;
        NSString *payType = self.payType;
        NSString *price = @"100";
        NSString *distance = self.distLbl.text;
        //NSLog(self.payTypeSwitch.enabled);
        
        if (![srcAddr isEqual:@""]
            &&![srcAddrLat isEqual:@""]
            &&![srcAddrLng isEqual:@""]
            &&![destAddr isEqual:@""]
            &&![destAddrLat isEqual:@""]
            &&![destAddrLng isEqual:@""]
            &&![loadTime isEqual:@""]
            &&!(truckTypes.count==0)
            &&![payType isEqual:@""]
            &&![price isEqual:@""]
            ) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认下单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                NSMutableArray *trklist = [[NSMutableArray alloc]init];

                
                //test
                Order* order = [[Order alloc]init];
                
                order.addressFrom = srcAddr;
                order.addressFromLat = srcAddrLat;
                order.addressFromLng= srcAddrLng;
                order.addressTo = destAddr;
                order.addressToLat = destAddrLat;
                order.addressToLng=destAddrLng;
                order.fromContactName = fromContactName;
                order.fromContactPhone = fromContactPhone;
                order.toContactName = toContactName;
                order.toContactPhone = toContactPhone;
                order.loadTime = loadTime;
                order.goodsType = goodsType;
                order.goodsWeight = goodsWeight;
                order.goodsSize = goodsSize;
                order.truckTypes = self.selectedTruckList;
                order.remark = remark;
                order.payType = payType;
                order.price = price;
                order.distance = distance;
                
                [User placeOrder:(Order *) order withBlock:^(NSError *error, User *user){
                    if (error) {
                        NSLog(@"PLACE ORDER FAILED!!!!");
                       // NSLog(order);
                        if ((long)error.code==1006) {
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"需要拆单" message:@"没有合适的司机，需要拆单吗？" preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                [User splitOrder:(Order *) order withBlock:^(NSError *error, User *user){
                                    if (error) {
                                        NSLog(@"split ORDER FAILED!!!!");
                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拆单失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                                        [alertController addAction:okAction];
                                        [self presentViewController:alertController animated:YES completion:nil];
                                        
                                    }else{
                                        
                                        NSLog(@"下单成功");
                                        
                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下单成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                            
                                            HomeViewController *setHomeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                                            
                                            //使用popToViewController返回并传值到上一页面
                                            [self.navigationController popToViewController:setHomeVC animated:true];
                                            
                                            
                                        }];
                                        [alertController addAction:okAction];
                                        [self presentViewController:alertController animated:YES completion:nil];
                                    }
                                }];
                                
                                
                            }];
                        
                            
                            [alert addAction:cancelAction];
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];
                        }else{
                        //NSLog(@"%ld",(long)error.code);
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下单失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        }
                    }else{
                        
                        NSLog(@"下单成功");
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下单成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                            
                            HomeViewController *setHomeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                            
                            //使用popToViewController返回并传值到上一页面
                            [self.navigationController popToViewController:setHomeVC animated:true];
                            
                            
                        }];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                        
                    }
                }];
            }];
            
            
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请填写带有*的信息" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }

    }
    //返回时取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)payTypeSwitch:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        self.payType = @"0";
    }else {
        self.payType = @"1";

    }
}
@end
