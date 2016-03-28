//
//  SubAddFreqDriverViewController.m
//  tongbao
//
//  Created by ZX on 16/3/28.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "SubAddFreqDriverViewController.h"
#import "User.h"
#import "Driver.h"
#import "SubAddDriverDtlViewController.h"


@interface SubAddFreqDriverViewController ()

@end

@implementation SubAddFreqDriverViewController

@synthesize drivers;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需要重新定义数据结构
    //drivers = [NSArray arrayWithObjects:@"李华", @"赵红梅", @"王磊", nil];
    //dtls = [NSArray arrayWithObjects:@"18951997878", @"13645361336", @"18997783231", nil];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.searchBar.delegate = self;
}




// 当用户在搜索框内输入文本时激发该方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 显示取消按钮
    searchBar.showsCancelButton = YES;
    // 通过遍历找到该搜索框内的取消按钮，并将取消按钮的文本设为“搜索”
    for (id cc in [searchBar.subviews[0] subviews])
    {
        if ([cc isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)cc;
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

//搜索框为空时清除锚点和列表
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchText==nil||searchText.length == 0)
    {
        self.drivers = nil;
        [self.table reloadData];
    }
    
}

//手指点击屏幕关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    
}

// 当用户单击虚拟键盘上的“搜索”按钮时激发该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // 调用searchBar方法进行搜索
    [self doSearch:searchBar];
}

// 当用户单击“取消”按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.searchBar.text=nil;
    self.drivers = nil;
   
    [self.table reloadData];
    
    searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    
}



// 执行搜索的方法
- (void)doSearch:(UISearchBar *)searchBar{
    // 关闭searchBar关联的虚拟键盘
    [self.searchBar resignFirstResponder];
    NSString* searchText = self.searchBar.text;
    if(searchText != nil && searchText.length > 0)
    {
        
        [User searchDriver: searchText withBlock:^(NSError *error, User *user)
         {
             
             if (error) {
                 NSLog(@"SEARCH FREQDriver FAILED!!!!");
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"搜索失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                 [alertController addAction:okAction];
                 [self presentViewController:alertController animated:YES completion:nil];
             }else{
                 //self.myNickname.text = new.text;
                 NSLog(@"SEARCH FREQDriver SUCCESSFULLY!");
                 self.drivers = user.driverList;
                 [self.table reloadData];
//                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"搜索成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                     SubAddrViewController *setsubAddrVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//                     
//                     //使用popToViewController返回并传值到上一页面
//                     [self.navigationController popToViewController:setsubAddrVC animated:true];
//                 }];
//                 [alertController addAction:okAction];
//                 [self presentViewController:alertController animated:YES completion:nil];
             }
         }];
        
        
    }
}





- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    NSInteger rowNo = indexPath.row;  // 获取行号
    // 根据行号的奇偶性使用不同的标识符
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             identifier forIndexPath:indexPath];
    Driver *driverItem = [self.drivers objectAtIndex:rowNo];
    // 获取cell内包含的Tag为1的UILabel
    UILabel* nickNameLbl = (UILabel*)[cell viewWithTag:1];
    nickNameLbl.text = driverItem.nickName;
    
    UILabel* phoneNumLbl = (UILabel*)[cell viewWithTag:2];
    phoneNumLbl.text = driverItem.phoneNum;
    
    
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section
{
    
    return drivers.count;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    NSInteger rowNo = indexPath.row;
//    
//    SubDriverDtlViewController* subDriverDtl = [self.storyboard instantiateViewControllerWithIdentifier: @"SubDriverDtl"];
//    
//    subDriverDtl.name = [drivers objectAtIndex:rowNo];
//    subDriverDtl.tel = [dtls objectAtIndex:rowNo];
//    
//    [self.navigationController pushViewController:subDriverDtl animated:YES];
//
    
    NSInteger rowNo = indexPath.row;
    
    
    SubAddDriverDtlViewController* subAddDriverDtlVC = [self.storyboard instantiateViewControllerWithIdentifier: @"SubAddDriverDtl"];
    Driver* driverItem = [self.drivers objectAtIndex:rowNo];
    subAddDriverDtlVC.driver = driverItem;
    //NSLog(@"%@", subEditFreqAddr.address);
    [self.navigationController pushViewController:subAddDriverDtlVC animated:YES];

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end