//
//  SearchView.h
//  CityLocation
//
//  Created by 于茂 on 27/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchViewChoseCityReultBlock)(NSDictionary *cityData);
typedef void(^SearchViewBlock)();

@interface SearchView : UIView

/** 搜索结果*/
@property (nonatomic, strong) NSMutableArray *resultMutableArray;

@property (nonatomic, copy) SearchViewChoseCityReultBlock resultBlock;
@property (nonatomic, copy) SearchViewBlock touchViewBlock;


/**
 点击搜索结果回调函数

 @param block 回调
 */
- (void)resultBlock:(SearchViewChoseCityReultBlock)block;


/**
 点击空白View回调，取消搜索

 @param block 回调
 */
- (void)touchViewBlock:(SearchViewBlock)block;


@end
