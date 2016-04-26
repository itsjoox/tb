//
//  GCJ02TOBD09.m
//  tongbao
//
//  Created by ZX on 16/4/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "GCJ02TOBD09.h"

//const double a = 6378245.0;
//const double ee = 0.00669342162296594323;
//const double pi = 3.14159265358979324;

const double my_pi = 3.14159265358979324 * 3000.0 / 180.0;

@implementation GCJ02TOBD09

+(CLLocationCoordinate2D)transformFromGCJToBD:(CLLocationCoordinate2D)gcjLoc
{
    CLLocationCoordinate2D adjustLoc;
    if([self isLocationOutOfChina:gcjLoc]){
        adjustLoc = gcjLoc;
    }else{
        double adjustLat = [self transformLatWithLat:gcjLoc.longitude withLon:gcjLoc.latitude];
        double adjustLon = [self transformLonWithLat:gcjLoc.longitude withLon:gcjLoc.latitude];
        
        adjustLoc.latitude = adjustLat;
        adjustLoc.longitude = adjustLon;
    }
    return adjustLoc;
}

//判断是不是在中国
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location
{
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}

+(double)transformLatWithLat:(double)lat withLon:(double)lon
{
    double x = lon, y = lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * my_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * my_pi);
    
    double latTrans = z * sin(theta) + 0.006;
    return latTrans;
}

+(double)transformLonWithLat:(double)lat withLon:(double)lon
{double x = lon, y = lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * my_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * my_pi);
    
    double lonTrans = z * cos(theta) + 0.0065;
    return lonTrans;
}



@end
