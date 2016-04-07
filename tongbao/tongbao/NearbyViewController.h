//
//  SecondViewController.h
//  tongbao
//
//  Created by ZX on 16/2/16.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NearbyViewController : UIViewController

@property (nonatomic, copy) NSString* caller;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)bn:(id)sender;

- (IBAction)currLoc:(id)sender;

- (IBAction)showList:(id)sender;
- (IBAction)locate:(id)sender;
- (IBAction)useCurrLoc:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBarCenter;

@property (strong, nonatomic) IBOutlet UITableView *resultTable;


@end

