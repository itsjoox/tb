//
//  SubOrderDtlViewController.h
//  tongbao
//
//  Created by ZX on 16/2/29.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "confirmedOrder.h"
@interface SubOrderDtlViewController : UITableViewController

@property (strong, nonatomic) NSString* myOrderState;
@property (strong, nonatomic) confirmedOrder* cfOrderItem;
@property (strong, nonatomic) NSString* myOrderTitle;
@property (strong, nonatomic) NSString* myOrderID;
@property (strong, nonatomic) NSString* myOrderDtl;
@property (strong, nonatomic) IBOutlet UILabel *orderState;
@property (strong, nonatomic) IBOutlet UILabel *orderNoLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLbl;
@property (strong, nonatomic) IBOutlet UITextView *srcAddrTxtView;
@property (strong, nonatomic) IBOutlet UITextField *senderNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *senderTelTxtFld;
@property (strong, nonatomic) IBOutlet UITextView *destAddrTxtView;
@property (strong, nonatomic) IBOutlet UITextField *receiverNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *receiverTelTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *truckTypesTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *loadTimeTxtFld;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *left;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *right;
- (IBAction)leftBtn:(id)sender;
- (IBAction)rightBtn:(id)sender;

@end

