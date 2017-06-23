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
    model.title = @"UIActivityViewController";
    model.method = @"activity";
    [self.dataSource addObject:model];
    
    model = [DemoListModel new];
    model.title = @"native + web";
    model.method = @"native";
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
    self.tableView.separatorInset = UIEdgeInsetsZero;
}


/**
 微信分享
 */
-(void)activity{
    
    
    NSArray *activityItems = @[[UIImage imageNamed:@"1.jpg"],
                               [UIImage imageNamed:@"2.jpg"],
                               [UIImage imageNamed:@"3.jpg"]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll,UIActivityTypePrint];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(void)touchID{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    DemoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            view.backgroundColor = [UIColor redColor];
            CGRect rect = view.frame;
            rect.size.height = 2;
            view.frame = rect;
            NSLog(@"%@", view);
        }
    }
    
    [TouchIDTool authenticate:^{
        
    } error:^(NSString *errMsg) {
        
    }];
}

-(void)videoPlayer{
    [self push:@"DemoTestViewController" params:@{@"type" : @1} animated:YES callback:nil];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPat{
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            view.backgroundColor = [UIColor redColor];
            CGRect rect = view.frame;
            rect.size.height = 2;
            view.frame = rect;
        }
    }
}

/**
 js 交互
 */
-(void)native{
    [self push:@"WebViewController" params:@{@"url": @"http://www.baidu.com"} animated:YES callback:^(id value) {
        
    }];
}
@end
