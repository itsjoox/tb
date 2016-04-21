//
//  SubAddrViewController.m
//  tongbao
//
//  Created by ZX on 16/2/22.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubAddrViewController.h"
#import "SubEditFreqAddrViewController.h"
#import "User.h"
#import "Address.h"



@interface SubAddrViewController ()

@end

@implementation SubAddrViewController

@synthesize addrs;
@synthesize dtls;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    dtls = [NSArray arrayWithObjects:@"", @"厢式货车", @"大卡车", nil];
    addrs = [NSArray arrayWithObjects:@"南京市鼓楼区汉口路22号", @"南京市鼓楼区广州路3号", @"南京市玄武区珠江路18号", nil];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.freqAddrList = [[NSMutableArray alloc]init];
    
    [User getFrequentAddresses:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get frequent addresses FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
           
            self.freqAddrList = user.freqAddrList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
        }
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [User getFrequentAddresses:^(NSError *error, User *user) {
        if(error){
            NSLog(@"Get frequent addresses FAILED!!!!");
        }else{
            NSLog(@"Now getting frequent addresses");
            
            self.freqAddrList = user.freqAddrList;
            //weakSelf.billList = user.billList;
            //[weakSelf.billTable reloadData];
            [self.table reloadData];
            
            
        }
    }];
    

}




- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
     Address* addr = [self.freqAddrList objectAtIndex:rowNo];
    
    // 获取cell内包含的Tag为1的UILabel
    UILabel* addrLbl = (UILabel*)[cell viewWithTag:1];
    addrLbl.text =addr.name;
    return cell;
     
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.freqAddrList.count;
    
}


- (IBAction)fromHere:(id)sender {
}

- (IBAction)toHere:(id)sender {
}

//可用segue方法
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"seg1"]) //"goView2"是SEGUE连线的标识
//            {
//                 NSLog(@"in");
//             //NSLog(segue.destinationViewController);
//                 id destController = segue.destinationViewController;
//                 //id dest = segue.destinationViewController;
//                 // 使用KVC方式将label内的文本设为destController的editContent属性值
//                
//                 [destController setValue:@"here" forKey:@"address"];
//             }
//
//
//            NSLog(@"here");
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    

    SubEditFreqAddrViewController* subEditFreqAddr = [self.storyboard instantiateViewControllerWithIdentifier: @"SubEditFreqAddr"];
    Address* addr = [self.freqAddrList objectAtIndex:rowNo];
    subEditFreqAddr.myAddr = addr;
    subEditFreqAddr.address = addr.name;
    //NSLog(@"%@", subEditFreqAddr.address);
    [self.navigationController pushViewController:subEditFreqAddr animated:YES];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end