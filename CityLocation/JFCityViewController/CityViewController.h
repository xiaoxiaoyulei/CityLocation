
//  ViewController.h
//  CityLocation
//
//  Created by 于茂 on 27/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CityViewControllerBlock)(NSString *cityName);

@interface CityViewController : UIViewController

@property (nonatomic, copy) CityViewControllerBlock choseCityBlock;
@property (nonatomic, assign) NSInteger sectionTotal;           //选择section的个数
@property (nonatomic, strong) UIColor *sectionColor;            //选择section的颜色


/**
 选择城市后的回调

 @param block 回调
 */
- (void)choseCityBlock:(CityViewControllerBlock)block;

@end
