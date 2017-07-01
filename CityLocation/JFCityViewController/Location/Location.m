//
//  Location.h
//  CityLocation
//
//  Created by 于茂 on 27/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import "Location.h"

#import <CoreLocation/CoreLocation.h>

@interface Location ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation Location

- (instancetype)init {
    if (self = [super init]) {
        [self startPositioningSystem];
    }
    return self;
}

- (void)startPositioningSystem {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    

}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (self.locationBlock) {
            self.locationBlock();
        }
    });
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *location = [placemark addressDictionary];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
          
                if (self.currentLocationBlock) {
                    self.currentLocationBlock(location);
                }
            });
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied) {

        if (self.messageBlock) {
            self.messageBlock(@"已拒绝使用定位系统");
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{

            if (self.messageBlock) {
                self.messageBlock(@"无法获取位置信息");
            }
        });
    }
}

#pragma mark --- LocationBlock

- (void)locateFailure:(LocationMessageBlock)block {
    self.messageBlock = block;
}

- (void)refuseToUsePositioningSystem:(LocationMessageBlock)block {
    self.messageBlock = block;
}

- (void)locating:(LocationBlock)block {
    self.locationBlock = block;
}

- (void)currentLocation:(LocationCurrentBlock)block{
    
    self.currentLocationBlock = block;
}
@end
