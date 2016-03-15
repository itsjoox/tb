//
//  RequestViewController.m
//  tongbao
//
//  Created by ZX on 16/2/27.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import "RequestViewController.h"

@interface RequestViewController ()


@property (strong, nonatomic) IBOutlet UITextField *useTimeTxtFld;

- (IBAction)useTime:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *fromAddrTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *toAddrTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *carTypeTxtFld;

@end

@implementation RequestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    
}


//处理次级页面传来的信息
-(void)viewDidAppear:(BOOL)animated
{
    self.fromAddrTxtFld.text = self.fromAddr;
    self.toAddrTxtFld.text = self.toAddr;
    self.carTypeTxtFld.text = self.carType;
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



@end
