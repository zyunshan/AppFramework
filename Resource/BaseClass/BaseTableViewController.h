//
//  BaseTableViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

/**
 数据源
 */
@property (strong, nonatomic) NSMutableArray *dataSource;

/**
 将 cell 与 model 绑定
 */
-(void)registerClass:(Class)cellClass forModelClass:(Class)modelClass;


/**
 将 model 与点击事件绑定,一种 model 对应一种 cell， 间接将 cell 与 mehtod 绑定
 */
-(void)registerClass:(Class)modelClass forClickMethod:(NSString *)method;
@end
