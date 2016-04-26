//
//  BD09TOGCJ02.h
//  tongbao
//
//  Created by ZX on 16/4/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BD09TOGCJ02 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromBDToGCJ:(CLLocationCoordinate2D)bdLoc;
@end