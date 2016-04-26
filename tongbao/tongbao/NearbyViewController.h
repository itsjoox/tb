//
//  SecondViewController.h
//  tongbao
//
//  Created by ZX on 16/2/16.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WGS84TOGCJ02.h"
#import "BD09TOGCJ02.h"
@interface NearbyViewController : UIViewController

@property (nonatomic, copy) NSString* caller;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)showList:(id)sender;
- (IBAction)locate:(id)sender;
- (IBAction)useCurrLoc:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBarCenter;

@property (strong, nonatomic) IBOutlet UITableView *resultTable;


@end

