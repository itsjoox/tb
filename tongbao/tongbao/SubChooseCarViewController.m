//
//  SubChooseCarViewController.m
//  tongbao
//
//  Created by ZX on 16/2/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubChooseCarViewController.h"
#import "RequestViewController.h"
@interface SubChooseCarViewController ()

@end

@implementation SubChooseCarViewController

@synthesize cars;
@synthesize dtls;

- (void)viewDidLoad {
    [super viewDidLoad];

    cars = [NSArray arrayWithObjects:@"面包车", @"厢式货车", @"大卡车", nil];
    dtls = [NSArray arrayWithObjects:@"南京市鼓楼区汉口路22号", @"南京市鼓楼区广州路3号", @"南京市玄武区珠江路18号", nil];
    self.table.dataSource = self;
    self.table.delegate = self;
  
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    NSInteger rowNo = indexPath.row;
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    // 获取cell内包含的Tag为2的UILabel
    UILabel* label = (UILabel*)[cell viewWithTag:2];
    label.text = [cars objectAtIndex:rowNo];
    
    return cell;

}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
    return cars.count;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
            RequestViewController *setRequest = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
            setRequest.carType = [self.cars objectAtIndex:indexPath.row];

            [self.navigationController popToViewController:setRequest animated:true];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

