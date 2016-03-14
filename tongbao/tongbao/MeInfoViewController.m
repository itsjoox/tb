//
//  MeInfoViewController.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/14.
//  Copyright © 2016年 ZX. All rights reserved.
//

//
//  MeInfoViewController.m
//  tongbao
//
//  Created by 蒋秉洁 on 16/3/13.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "MeInfoViewController.h"

@interface MeInfoViewController()



@end


@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger rowNo = indexPath.row;
//    if (rowNo == 0){
//        NSLog(@"toux");
//    }
//
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // tap row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger rowNo = indexPath.row;
    
    if (rowNo == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拍照/选择一张照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        //UIAlertControllerStyleActionSheet 是你示意图的效果
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *TakeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *SelectAction = [UIAlertAction actionWithTitle:@"从相册选择照片" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:cancelAction];
        [alert addAction:TakeAction];
        [alert addAction:SelectAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (rowNo == 1){
        NSLog(@"1");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"请输入新的昵称";
        }];
        //        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //            textField.placeholder = @"密码";
        //            textField.secureTextEntry = YES;
        //        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *login = alert.textFields.firstObject;
            NSLog(@"%@",login);
            //            UITextField *password = alert.textFields.lastObject;
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"UIActionSheet" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"呵呵" otherButtonTitles:@"嘿嘿", @"哈哈", nil];
//    [actionSheet showInView:self.view];

//    UIActionSheet 在8.3之后已经被废弃了，而是采用了UIAlertView，如下:


#pragma mark - UIActionSheetDelegate

//- (void)actionSheetCancel:(UIActionSheet *)actionSheet
//{
//    NSLog(@"Press Cancel");
//}
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"Click: %@", @(buttonIndex));
//}
//



@end
