//
//  RequestViewController.m
//  tongbao
//
//  Created by ZX on 16/2/27.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "RequestViewController.h"
#import "User.h"

@interface RequestViewController ()


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

@property (strong, nonatomic) IBOutlet UISwitch *payOnlineSwitch;
@property (strong, nonatomic) IBOutlet UITextView *psTxtView;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation RequestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.delegate = self;
    
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
   
    
    
    self.srcAddrTxtFld.text = srcAddress;
    self.destAddrTxtFld.text = destAddress;
    self.carTypeTxtFld.text = self.carType;

    
    
    
    
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
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.useTimeTxtFld.text = dateString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    //NSInteger rowNo = indexPath.row;
    if (section==6) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认下单" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
//            textField.placeholder = @"请输入新的昵称";
//        }];
        //        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //            textField.placeholder = @"密码";
        //            textField.secureTextEntry = YES;
        //        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            UITextField *new = alert.textFields.firstObject;
//            NSLog(@"修改后的昵称！！%@",new.text);
//            NSDictionary* orderDetail = @{@"addressFrom":self.srcAddrTxtFld.text,
//                                          @"addressFromLat":@"",
//                                          @"addressFromLng":@"",
//                                          @"addressTo":self.destAddrTxtFld.text,
//                                          @"addressToLat":@"",
//                                          @"addressToLng":@"",
//                                          @"fromContactName":self.senderNameTxtFld.text,
//                                          @"fromContactPhone":self.senderTelTxtFld.text,
//                                          @"toContactName":self.receiverNameTxtFld.text,
//                                          @"toContactPhone":self.recevierTelTxtFld.text,
//                                          @"loadTime":self.useTimeTxtFld.text,
//                                          @"goodsType":self.cargoTypeTxtFld.text,
//                                          @"goodsWeight":self.cargoWeightTxtFld.text,
//                                          @"goodsSize":self.cargoVolumeTxtFld.text,
//                                          @"truckTypes":self.carTypeTxtFld.text,
//                                          @"remark":self.psTxtView.text,
//                                          @"payType":@"",
//                                          @"price":self.moneyLbl.text
//                                          };
//            
            //NSDictionary这种初始化方式不能有nil
            NSDictionary *orderDetail = @{@"addressFrom":@"1",
                                          @"addressFromLat":@"1",
                                          @"addressFromLng":@"1",
                                          @"addressTo":@"1",
                                          @"addressToLat":@"1",
                                          @"addressToLng":@"1",
                                          @"fromContactName":@"1",
                                          @"fromContactPhone":@"1",
                                          @"toContactName":@"1",
                                          @"toContactPhone":@"1",
                                          @"loadTime":@"1",
                                          @"goodsType":@"1",
                                          @"goodsWeight":@"1",
                                          @"goodsSize":@"1",
                                          @"truckTypes":@"1",
                                          @"remark":@"1",
                                          @"payType":@"1",
                                          @"price":@"1"};
            
            
            [User placeOrder:(NSDictionary *) orderDetail withBlock:^(NSError *error, User *user){
                if (error) {
                     NSLog(@"PLACE FAILED!!!!");
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下单失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                     [alertController addAction:okAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }else{
                     NSLog(@"下单成功");
                 }
            }];
        }];
    
    
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    

    }
}

@end
