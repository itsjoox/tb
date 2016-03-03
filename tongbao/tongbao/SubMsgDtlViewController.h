//
//  SubMsgDtlViewController.h
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubMsgDtlViewController : UIViewController

@property (strong, nonatomic) NSString* myMsgTitle;
@property (strong, nonatomic) NSString* myOrderNo;
@property (strong, nonatomic) NSString* myMsgDtl;

@property (strong, nonatomic) IBOutlet UILabel *msgTitle;
@property (strong, nonatomic) IBOutlet UILabel *orderNo;

@end
