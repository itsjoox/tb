//
//  GCJ02TOBD09.h
//  tongbao
//
//  Created by ZX on 16/4/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GCJ02TOBD09 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromGCJToBD:(CLLocationCoordinate2D)gcjLoc;
@end