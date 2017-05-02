//
//  BaseTableViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewController ()

/**
 cell 和 model 关联字典
 */
@property (nonatomic, strong) NSMutableDictionary *cellModelInfo;

/**
 model 和 method 关联字段
 */
@property (nonatomic, strong) NSMutableDictionary *modelMethodInfo;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    NSInteger bottomMargin = 49;
    if (self.hidesBottomBarWhenPushed) {
        bottomMargin = 0;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cs_nav_height);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomMargin);
    }];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableDictionary *)cellModelInfo{
    if (!_cellModelInfo) {
        _cellModelInfo = [NSMutableDictionary new];
    }
    return _cellModelInfo;
}

-(NSMutableDictionary *)modelMethodInfo{
    if (!_modelMethodInfo) {
        _modelMethodInfo = [NSMutableDictionary new];
    }
    return _modelMethodInfo;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - 自定义方法
-(void)registerClass:(Class)cellClass forModelClass:(Class)modelClass{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    if (nib) {
        [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }else{
        [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
    [self.cellModelInfo setObject:NSStringFromClass(cellClass) forKey:NSStringFromClass(modelClass)];
}

-(void)registerClass:(Class)modelClass forClickMethod:(NSString *)method{
    [self.modelMethodInfo setObject:method forKey:NSStringFromClass(modelClass)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        return self.dataSource.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        return [self.dataSource[section] count];
    }
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model;
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        model = self.dataSource[indexPath.section][indexPath.row];
    }else{
        model = self.dataSource[indexPath.row];
    }
    NSString *modelClass = NSStringFromClass([model class]);
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[self.cellModelInfo objectForKey:modelClass]];
    [cell updateCellWithModel:model];
    cell.clickCallback = ^(NSInteger tag, id info){
        NSString *method = [model valueForKey:@"cellCallbackMethod"];
        if ([self respondsToSelector:NSSelectorFromString(method)]) {
            SEL selector = NSSelectorFromString(method);
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL, id, id) = (void *)imp;
            func(self, selector, model, info);
        }
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model;
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        model = self.dataSource[indexPath.section][indexPath.row];
    }else{
        model = self.dataSource[indexPath.row];
    }
    NSString *method = [model valueForKey:@"method"];
    NSString *modelClass = NSStringFromClass([model class]);
    if ([self respondsToSelector:NSSelectorFromString(method)]) {
        SEL selector = NSSelectorFromString(method);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, selector, model);
    }else if ([self.modelMethodInfo objectForKey:modelClass]){
        NSString *method = [self.modelMethodInfo objectForKey:modelClass];
        if ([self respondsToSelector:NSSelectorFromString(method)]) {
            SEL selector = NSSelectorFromString(method);
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL, id) = (void *)imp;
            func(self, selector, model);
        }
    }
}
@end
