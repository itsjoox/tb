//
//  BD09TOGCJ02.m
//  tongbao
//
//  Created by ZX on 16/4/25.
//  Copyright © 2016年 ZX. All rights reserved.
//

#import "BD09TOGCJ02.h"

//const double a = 6378245.0;
//const double ee = 0.00669342162296594323;
//const double pi = 3.14159265358979324;

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;

@implementation BD09TOGCJ02

+(CLLocationCoordinate2D)transformFromBDToGCJ:(CLLocationCoordinate2D)bdLoc
{
    CLLocationCoordinate2D adjustLoc;
    if([self isLocationOutOfChina:bdLoc]){
        adjustLoc = bdLoc;
    }else{
        double adjustLat = [self transformLatWithLat:bdLoc.longitude withLon:bdLoc.latitude];
        double adjustLon = [self transformLonWithLat:bdLoc.longitude withLon:bdLoc.latitude];
       
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

+(double)transformLonWithLat:(double)lat withLon:(double)lon
{
    double x = lon - 0.0065, y = lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    
   double lonTrans = z * sin(theta);
    return lonTrans;
}

+(double)transformLatWithLat:(double)lat withLon:(double)lon
{
    double x = lon - 0.0065, y = lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double latTrans = z * cos(theta);
    return latTrans;
}



@end
