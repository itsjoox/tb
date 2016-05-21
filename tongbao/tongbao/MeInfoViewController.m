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
#import "User.h"

@interface MeInfoViewController()

@property (weak, nonatomic) IBOutlet UIImageView *myHeadPortrait;
@property (weak, nonatomic) IBOutlet UITextField *myNickname;
@property (weak, nonatomic) IBOutlet UILabel *myTelephone;
@property (weak, nonatomic) IBOutlet UITextField *myPassword;


@end


@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setHeadPortrait];
    self.myNickname.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    self.myTelephone.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // tap row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger rowNo = indexPath.row;
    
    if (rowNo == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拍照/选择一张照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        //UIAlertControllerStyleActionSheet 是你示意图的效果
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *TakeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            /**
             其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
             */
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [self presentViewController:PickerImage animated:YES completion:nil];
        }];
        
        UIAlertAction *SelectAction = [UIAlertAction actionWithTitle:@"从相册选择照片" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
            //初始化UIImagePickerController
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
            //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
            //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
            PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //允许编辑，即放大裁剪
            PickerImage.allowsEditing = YES;
            //自代理
            PickerImage.delegate = self;
            //页面跳转
            [self presentViewController:PickerImage animated:YES completion:nil];
        }];
        
        
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
            UITextField *new = alert.textFields.firstObject;
            NSLog(@"修改后的昵称！！%@",new.text);
            [User modifyNickname:new.text withBlock:^(NSError *error, User *user)
                {
                    if (error) {
                        NSLog(@"MODIFY FAILED!!!!");
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }else{
                        self.myNickname.text = new.text;
                    }
            }];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if(rowNo == 2){
        NSLog(@"2");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"请输入新的密码";
            textField.secureTextEntry = YES;
        }];
        //        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //            textField.placeholder = @"密码";
        //            textField.secureTextEntry = YES;
        //        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *new = alert.textFields.firstObject;
            NSLog(@"修改后的密码！！%@",new.text);
            [User modifyPassword:new.text withBlock:^(NSError *error, User *user)
             {
                 if (error) {
                     NSLog(@"MODIFY FAILED!!!!");
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改失败" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                     [alertController addAction:okAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }else{
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"您的密码已更新" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:nil];
                     [alertController addAction:okAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }
             }];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
}

#pragma mark - image picker delegte
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _myHeadPortrait.image = newPhoto;
    [User uploadImage:newPhoto withBlock:^(NSError *error, User *user) {
        if(error){
            NSLog(@"UPLOAD Head portrait FAILED!!!!");
        }else{
            NSLog(@"Now modifying head with %@",user.iconUrl);
            [User modifyHeadportrait:user.iconUrl withBlock:^(NSError *error, User *user) {
                if(error){
                    NSLog(@"MODIFY Head portrait FAILED!!!!");
                }else{
                    NSLog(@"MODIFY Head portrait SUCCESSFULLY!!!!");
                    [self setHeadPortrait];
                }
            }];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  设置头像样式
-(void)setHeadPortrait{
//    NSLog(@"设置头像！！ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]);
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]){
        [self.myHeadPortrait setImage: [User getImageFromURL: [[NSUserDefaults standardUserDefaults] objectForKey:@"headPortrait"]]];
    }
//    //  把头像设置成圆形
//    self.myHeadPortrait.layer.cornerRadius=self.myHeadPortrait.frame.size.width/2;
//    self.myHeadPortrait.layer.masksToBounds=YES;
//    //  给头像加一个圆形边框
//    self.myHeadPortrait.layer.borderWidth = 1.5f;
//    self.myHeadPortrait.layer.borderColor = [UIColor whiteColor].CGColor;
}




@end
