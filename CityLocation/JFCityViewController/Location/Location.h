//
//  Location.h
//  CityLocation
//
//  Created by 于茂 on 27/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)();
typedef void(^LocationMessageBlock)(NSString *message);
typedef void(^LocationCurrentBlock)(NSDictionary *locationDictionary);

@interface Location : NSObject

@property (nonatomic, assign) LocationBlock locationBlock;
@property (nonatomic, strong) LocationMessageBlock messageBlock;
@property (nonatomic, strong) LocationCurrentBlock currentLocationBlock;

/**
 定位失败回调的代理
 
 @param block 提示信息
 */
- (void)locateFailure:(LocationMessageBlock)block;
/**
 拒绝定位后回调的代理
 
 @param block 提示信息
 */
- (void)refuseToUsePositioningSystem:(LocationMessageBlock)block;
/**
 定位后回调的代理
 
 @param block 提示信息
 */
- (void)locating:(LocationBlock)block;

/**
 当前位置
 
 @param block 位置信息字典
 */
- (void)currentLocation:(LocationCurrentBlock)block;



@end
