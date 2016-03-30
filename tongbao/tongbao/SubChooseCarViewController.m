//
//  SubChooseCarViewController.m
//  tongbao
//
//  Created by ZX on 16/2/24.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubChooseCarViewController.h"
#import "RequestViewController.h"
#import "User.h"
#import "Truck.h"


@interface SubChooseCarViewController ()

@end

@implementation SubChooseCarViewController

@synthesize truckList;
@synthesize selectedTruckList;

- (void)viewDidLoad {
    [super viewDidLoad];

   
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table setEditing:YES animated:YES];
    self.truckList = [[NSArray alloc]init];
    self.selectedTruckList = [[NSMutableArray alloc]init];
    
    [User getAllTruckTypes:^(NSError *error, User *user){
        if(error){
            NSLog(@"Get Messages FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
            
            self.truckList = user.truckList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
            //int count=0;
            //            for(Bill* b in weakSelf.billList){
            //                NSLog(@"%d %@",count++,b.contents);
            //            }
            
            
        }
    }];
    
  
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    NSInteger rowNo = indexPath.row;
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    
    Truck *truckItem = [self.truckList objectAtIndex:rowNo];
    // 获取cell内包含的Tag为2的UILabel
    UILabel* nameLbl = (UILabel*)[cell viewWithTag:2];
    nameLbl.text = truckItem.name;

    UILabel* basePriceLbl = (UILabel*)[cell viewWithTag:3];
    NSMutableString *basePriceStr = [[NSMutableString alloc] init];
    [basePriceStr appendString:[truckItem.basePrice stringValue]];
    [basePriceStr appendString:@"元/"];
    [basePriceStr appendString:[truckItem.baseDistance stringValue]];
    [basePriceStr appendString:@"km"];
    basePriceLbl.text = basePriceStr ;
    
    UILabel* capacityLbl = (UILabel*)[cell viewWithTag:4];
    NSMutableString *capacityStr = [[NSMutableString alloc] init];
    [capacityStr appendString:[truckItem.capacity stringValue]];
    [capacityStr appendString:@"t"];
    capacityLbl.text = capacityStr;
    
    
    UILabel* lwhLbl = (UILabel*)[cell viewWithTag:5];
    NSMutableString *lwhStr = [[NSMutableString alloc] init];
    [lwhStr appendString:[truckItem.length stringValue]];
    [lwhStr appendString:@"m*"];
    [lwhStr appendString:[truckItem.width stringValue]];
    [lwhStr appendString:@"m*"];
    [lwhStr appendString:[truckItem.height stringValue]];
    [lwhStr appendString:@"m"];
    lwhLbl.text = lwhStr;
    
    UILabel* overPriceLbl = (UILabel*)[cell viewWithTag:6];
    NSMutableString *overPriceStr = [[NSMutableString alloc] init];
    [overPriceStr appendString:[truckItem.overPrice stringValue]];
    [overPriceStr appendString:@"元/km"];
    overPriceLbl.text = overPriceStr;
    
    
    return cell;

}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.truckList.count;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Truck *truckItem = [self.truckList objectAtIndex:indexPath.row];
    [self.selectedTruckList addObject:truckItem];
    
    
    
    
}

//取消一项
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    Truck *truckItem = [self.truckList objectAtIndex:indexPath.row];
    [self.selectedTruckList removeObject:truckItem];
    //        NSLog(@"Deselect---->:%@",self.selectedDic);
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneSelectedTruck:(id)sender {
    RequestViewController *setRequest = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    setRequest.selectedTruckList = self.selectedTruckList;

    [self.navigationController popToViewController:setRequest animated:true];
    
}
@end

