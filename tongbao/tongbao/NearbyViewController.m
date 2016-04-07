//
//  NearbyViewController.m
//  tongbao
//
//  Created by ZX on 16/2/16.
//  Copyright © 2016年 ZX. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "NearbyViewController.h"
#import "SubChooseAddrViewController.h"


@interface NearbyViewController () <CLLocationManagerDelegate,MKMapViewDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) NSArray *placemarcs;
@property (strong, nonatomic) NSArray *mpItms;
@property (strong, nonatomic) MKPointAnnotation *point;
@property (strong, nonatomic) CLPlacemark *placemark;

@end



@implementation NearbyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.view.backgroundColor = UIColor.whiteColor;

    self.geocoder = [[CLGeocoder alloc]init];
    // 设置地图的显示风格，此处设置使用标准地图
    self.mapView.mapType = MKMapTypeStandard;
    // 设置地图可缩放
    self.mapView.zoomEnabled = YES;
    // 设置地图可滚动
    self.mapView.scrollEnabled = YES;
    // 设置地图可旋转
    self.mapView.rotateEnabled = YES;
    // 设置显示用户当前位置
    self.mapView.showsUserLocation = YES;
    // 为MKMapView设置delegate
    self.mapView.delegate = self;
    // 为SearchBar设置delegate
    self.searchBar.delegate = self;
    
    self.resultTable.dataSource = self;
    self.resultTable.delegate = self;
    
    self.point = [[MKPointAnnotation alloc]init];
    
    // 创建一个手势处理器，用于检测、处理长按手势
    UILongPressGestureRecognizer* gesture = [[UILongPressGestureRecognizer
                                              alloc]initWithTarget:self action:@selector(longPress:)];
   
    // 为该控件添加手势处理器
    [self.view addGestureRecognizer:gesture];
  
    [self.resultTable setHidden:YES];
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
            self.mpItms = nil;
            [self.mapView removeAnnotation:self.point];
            [self.resultTable reloadData];
            
            self.toolBarCenter.title = @"";
            [self.resultTable setHidden:YES];
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
    self.toolBarCenter.title = @"隐藏列表";
    [self.resultTable setHidden:NO];
}

// 当用户单击“取消”按钮时激发该方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.searchBar.text=nil;
    self.placemarcs = nil;
    [self.mapView removeAnnotation:self.point];
    [self.resultTable reloadData];
    
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
        [self locateAt:searchText];
    }
}

// 将字符串地址转换为经度、纬度信息，并执行定位
-(void)locateAt:(NSString*)address{
    
//    [self.geocoder geocodeAddressString:address completionHandler:
//     ^(NSArray *placemarks, NSError *error)
//     {
//         if ([placemarks count] > 0 && error == nil)
//         {
//             self.placemarcs = placemarks;
//             [self.resultTable reloadData];
//            
//             
//             // 处理第一个地址
//             self.placemark = [placemarks objectAtIndex:0];
//
//             [self pinOnMap:self.placemark.location.coordinate pinTitle:self.placemark.name pinSubTitle:nil];
//
//         }
//         else
//         {
//             NSLog(@"没有搜索到匹配数据");
//         }
//     }];
    
    
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = address;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {  // 得到一个MKMapItem 数组，里面还包含MKPlacemark
        if ([response.mapItems count]>0 && error == nil) {
            
            self.mpItms = response.mapItems;
            [self.resultTable reloadData];
            
            NSLog(@"搜索到匹配%lu条地址数据.", (unsigned long)response.mapItems.count);
            // 处理第一个地址
            
            MKMapItem* mpitm = [self.mpItms objectAtIndex:0];
            self.placemark = mpitm.placemark;
//            NSArray* addrArray = self.placemark
//            .addressDictionary[@"FormattedAddressLines"];
//            // 将详细地址拼接成一个字符串
//            NSMutableString* address = [[NSMutableString alloc] init];
//            for(int i = 0 ; i < addrArray.count ; i ++)
//            {
//                [address appendString:addrArray[i]];
//            }
//      
//            // 设置地图显示的范围
//            MKCoordinateSpan span;
//            // 地图显示范围越小，细节越清楚
//            span.latitudeDelta = 0.01;
//            span.longitudeDelta = 0.01;
//            MKCoordinateRegion region = {self.placemark.location.coordinate,span};
//            // 设置地图中心位置为搜索到的位置
//            [self.mapView setRegion:region];  // ①
//            // 设置地图锚点的坐标
//            if (self.point!=nil) {
//                [self.mapView removeAnnotation:self.point];
//            }
//            self.point.coordinate = self.placemark.location.coordinate;
//            // 设置地图锚点的标题
//            self.point.title = self.placemark.name;
//            // 设置地图锚点的副标题
//            self.point.subtitle = nil;
//            // 将地图锚点添加到地图上
//            [self.mapView addAnnotation:self.point];
//            // 选中指定锚点
//            [self.mapView selectAnnotation:self.point animated:YES];
            [self pinOnMap:self.placemark.location.coordinate pinTitle:self.placemark.name pinSubTitle:nil];
            
        }else{
            NSLog(@"没有搜索到匹配数据");
        }
    }];
    

}




//定义列表的单元
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger rowNo = indexPath.row;
    NSString* identifier = @"cell1";
    // 根据identifier获取表格行
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //CLPlacemark *plcmk = [self.placemarcs objectAtIndex:rowNo];
    MKMapItem *mpItm = [self.mpItms objectAtIndex:rowNo];
    CLPlacemark *plcmk = mpItm.placemark;
    NSArray* addrArray = plcmk.addressDictionary[@"FormattedAddressLines"];
    // 将详细地址拼接成一个字符串
    NSMutableString* address = [[NSMutableString alloc] init];
    for(int i = 0 ; i < addrArray.count ; i ++) {
        [address appendString:addrArray[i]];
    }
    
    // 获取cell内包含的Tag为1的UILabel
    UILabel* name = (UILabel*)[cell viewWithTag:1];
    name.text = plcmk.name;
    
    UILabel* addr = (UILabel*)[cell viewWithTag:2];
    addr.text = address;
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    
    //return self.placemarcs.count;
    return self.mpItms.count;
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger rowNo = indexPath.row;
    MKMapItem *mpItm = [self.mpItms objectAtIndex:rowNo];
    self.placemark = mpItm.placemark;
    
    //self.placemark = [self.placemarcs objectAtIndex:rowNo];
    //在地图上定位
    [self pinOnMap:self.placemark.location.coordinate pinTitle:self.placemark.name pinSubTitle:nil];

}

- (void) longPress:(UILongPressGestureRecognizer*)gesture{
    
    // 获取长按点的坐标
    CGPoint pos = [gesture locationInView:self.mapView];
    // 将长按点的坐标转换为经度、维度值
    CLLocationCoordinate2D coord = [self.mapView convertPoint:pos toCoordinateFromView:self.mapView];
    // 将经度、维度值包装为CLLocation对象
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    // 根据经、纬度反向解析地址
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (placemarks.count > 0 && error == nil)
         {
             // 获取解析得到的第一个地址信息
             self.placemark = [placemarks objectAtIndex:0];
             // 获取地址信息中的FormattedAddressLines对应的详细地址
             NSArray* addrArray = self.placemark
             .addressDictionary[@"FormattedAddressLines"];
             // 将详细地址拼接成一个字符串
             NSMutableString* address = [[NSMutableString alloc] init];
             for(int i = 0 ; i < addrArray.count ; i ++){
                 [address appendString:addrArray[i]];
             }
             
             if (self.point!=nil) {
                 [self.mapView removeAnnotation:self.point];
             }
             self.point.title = @"已放置的大头针";
             self.point.subtitle = address;
             self.point.coordinate = coord;
             // 添加锚点
             [self.mapView addAnnotation:self.point];
         }
     }];
}


-(void)pinOnMap:(CLLocationCoordinate2D) coordinate pinTitle:(NSString*) title pinSubTitle:(NSString*) subtitle {
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region = {coordinate,span};
    // 设置地图中心位置为搜索到的位置
    [self.mapView setRegion:region];
    // 设置地图锚点的坐标
    if (self.point!=nil) {
        [self.mapView removeAnnotation:self.point];
    }
    self.point.coordinate = coordinate;
    // 设置地图锚点的标题
    self.point.title = title;
    // 设置地图锚点的副标题
    self.point.subtitle = subtitle;
    // 将地图锚点添加到地图上
    [self.mapView addAnnotation:self.point];
    // 选中指定锚点
    [self.mapView selectAnnotation:self.point animated:YES];
}

// MKMapViewDelegate协议中的方法，该方法的返回值可用于定制锚点控件的外观
- (MKAnnotationView *) mapView:(MKMapView *)mapView
             viewForAnnotation:(id <MKAnnotation>) annotation{
    
    static NSString* annoId = @"fkAnno";
    // 获取可重用的锚点控件
    MKPinAnnotationView* annoView = (MKPinAnnotationView *)[mapView
                                                            dequeueReusableAnnotationViewWithIdentifier:annoId];
    // 如果可重用的锚点控件不存在，创建新的可重用锚点控件
    if (!annoView){
        annoView= [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annoId];
    }
    
    //当前位置显示为蓝圆点
    if ([[annotation title] isEqualToString:@"Current Location"]) {
        return nil;
    }
    
    // 为锚点控件设置图片
    //annoView.image = [UIImage imageNamed:@""];
    
    // 设置该锚点控件是否可显示气泡信息
    annoView.canShowCallout = YES;
    annoView.animatesDrop = YES ;
    // 定义一个按钮，用于为锚点控件设置附加控件
    UIButton *dtl = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    // 为按钮绑定事件处理方法
    [dtl addTarget:self action:@selector(dtlBtnTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    // 通过锚点控件的rightCalloutAccessoryView设置附加控件
    annoView.rightCalloutAccessoryView = dtl;
    
    return annoView;
    
}

//点击大头针详细信息按钮
- (void) dtlBtnTapped:(id)sender{
    
    //NSLog(@"您点击了锚点信息！");
    SubChooseAddrViewController* subChooseAddr = [self.storyboard instantiateViewControllerWithIdentifier: @"SubChooseAddr"];
    
    //设置调用者
     subChooseAddr.caller = self.caller;
    
    subChooseAddr.placemark = self.placemark;
    [self.navigationController pushViewController:subChooseAddr animated:YES];
    
    
}


- (IBAction)showList:(id)sender {
    if ([self.toolBarCenter.title isEqualToString:@"显示列表"]) {
        [self.resultTable setHidden:NO];
        
        self.toolBarCenter.title = @"隐藏列表";
        
    }else{
        [self.resultTable setHidden:YES];
        
        self.toolBarCenter.title = @"显示列表";
        //[self.mapView convertPoint
    }
}

- (IBAction)locate:(id)sender {
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.010;
    span.longitudeDelta=0.010;
    region.span=span;
    region.center=[self.mapView.userLocation coordinate];
    
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (IBAction)useCurrLoc:(id)sender {
    
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:
     ^(NSArray *placemarks, NSError *error)
     {
         if (placemarks.count > 0 && error == nil)
         {
             // 获取解析得到的第一个地址信息
             CLPlacemark* plcmk = [placemarks objectAtIndex:0];
             // 获取地址信息中的FormattedAddressLines对应的详细地址
             SubChooseAddrViewController* subChooseAddr = [self.storyboard instantiateViewControllerWithIdentifier: @"SubChooseAddr"];
             
             //设置调用者
             subChooseAddr.caller = self.caller;
             
             subChooseAddr.placemark = plcmk;
             [self.navigationController pushViewController:subChooseAddr animated:YES];
             
         }
     }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
