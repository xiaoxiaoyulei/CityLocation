//
//  ViewController.h
//  CityLocation
//
//  Created by 于茂 on 24/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import "ViewController.h"

#import "Location.h"
#import "JFAreaDataManager.h"
#import "CityViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface ViewController ()

/** 选择的结果 */
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
/** 城市定位管理器 */
@property (nonatomic, strong) Location *locationManager;
/** 城市数据管理器 */
@property (nonatomic, strong) JFAreaDataManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[Location alloc] init];
    
    // 定位中
    [self.locationManager locating:^(NSString *message) {
        NSLog(@"定位中...");
    }];
    
    //定位成功
    [self.locationManager currentLocation:^(NSDictionary *locationDictionary) {
        
        NSString *city = [locationDictionary valueForKey:@"City"];
        if (![_resultLabel.text isEqualToString:city]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _resultLabel.text = city;
                [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
                [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
                [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                    [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
                }];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }

    }];
    
    
    /// 拒绝定位
    [self.locationManager refuseToUsePositioningSystem:^(NSString *message) {
        NSLog(@"%@", message);
    }];
    
    /// 定位失败
    [self.locationManager locateFailure:^(NSString *message) {
        NSLog(@"%@", message);
    }];
    
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (IBAction)didClickedButtonEvent:(UIButton *)sender {
    
    CityViewController *cityViewController = [[CityViewController alloc] init];
    
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    
    cityViewController.sectionColor = [UIColor greenColor]; // 设置索引字的颜色
    
    [cityViewController choseCityBlock:^(NSString *cityName) {
        weakSelf.resultLabel.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
