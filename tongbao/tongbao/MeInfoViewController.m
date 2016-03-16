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

@property (weak, nonatomic) IBOutlet UIImageView *myHeadPortrait;

@end


@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setHeadPortrait];
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
            UITextField *login = alert.textFields.firstObject;
            NSLog(@"%@",login.text);
            //            UITextField *password = alert.textFields.lastObject;
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}


//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _myHeadPortrait.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  方法：设置头像样式
-(void)setHeadPortrait{
//    //  把头像设置成圆形
//    self.myHeadPortrait.layer.cornerRadius=self.myHeadPortrait.frame.size.width/2;
//    self.myHeadPortrait.layer.masksToBounds=YES;
//    //  给头像加一个圆形边框
//    self.myHeadPortrait.layer.borderWidth = 1.5f;
//    self.myHeadPortrait.layer.borderColor = [UIColor whiteColor].CGColor;
}





//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"UIActionSheet" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"呵呵" otherButtonTitles:@"嘿嘿", @"哈哈", nil];
//    [actionSheet showInView:self.view];

//    UIActionSheet 在8.3之后已经被废弃了，而是采用了UIAlertView，如下:



@end
