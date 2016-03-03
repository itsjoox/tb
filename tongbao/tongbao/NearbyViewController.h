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


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)bn:(id)sender;

- (IBAction)currLoc:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *resultTable;

@end

