//
//  DemoViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoTableViewCell.h"
#import "TouchIDTool.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"样式";
    
}

/**
 配置显示数据
 */
-(void)configData{
    DemoListModel *model = [DemoListModel new];
    model.title = @"循环滚动视图";
    model.method = @"cycleView";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"视频播放";
    model.method = @"videoPlayer";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"TouchID";
    model.method = @"touchID";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"Sqlite";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"苹果内购";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"推送";
    [self.dataSource addObject:model];
}

/**
 配置 tableView
 */
-(void)configTableView{
    [self registerClass:[DemoTableViewCell class] forModelClass:[DemoListModel class]];
}


/**
 循环滚动视图
 */
-(void)cycleView{
    
}

-(void)touchID{
    [TouchIDTool authenticate:^{
        
    } error:^(NSString *errMsg) {
        
    }];
}

-(void)videoPlayer{
    [self push:@"DemoTestViewController" params:@{@"type": @1}];
}
@end
