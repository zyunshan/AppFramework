//
//  BaseTableViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

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


/**
 点击 cell 上按钮时回调方法

 @param indexPath 当前 cell的位置
 @param tag 事件标记
 @param other 其他信息
 */
-(void)clickIndexPath:(NSIndexPath *)indexPath withTag:(NSInteger)tag other:(id)other;

/**
 重新加载
 */
-(void)reloadData;
@end
