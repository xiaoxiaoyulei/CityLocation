//
//  SearchView.h
//  CityLocation
//
//  Created by 于茂 on 27/02/2017.
//  Copyright © 2017 于茂. All rights reserved.
//

#import "SearchView.h"

static NSString *ID = @"searchCell";

@interface SearchView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;

@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setResultMutableArray:(NSMutableArray *)resultMutableArray {
    _resultMutableArray = resultMutableArray;
    [self addSubview:self.rootTableView];
    [_rootTableView reloadData];
}

- (UITableView *)rootTableView {
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_rootTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.backgroundColor = [UIColor clearColor];
    }
    return _rootTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NSDictionary *dataDic = _resultMutableArray[indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%@，%@",[dataDic valueForKey:@"city"],[dataDic valueForKey:@"super"]];
    cell.textLabel.text = text;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDic = _resultMutableArray[indexPath.row];
    if (![[dataDic valueForKey:@"city"] isEqualToString:@"抱歉"]) {
        if (self.resultBlock) {
            self.resultBlock(dataDic);
        }
    }
}

- (void)resultBlock:(SearchViewChoseCityReultBlock)block {
    self.resultBlock = block;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchViewBlock) {
        self.touchViewBlock();
    }
}

- (void)touchViewBlock:(SearchViewBlock)block {
    self.touchViewBlock = block;
}
@end
