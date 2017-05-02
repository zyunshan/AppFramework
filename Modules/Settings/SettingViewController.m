//
//  SettingViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingKindCell1.h"
#import "SettingKindCell2.h"
#import "SettingKindCell3.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    [self registerClass:[SettingKindCell1 class] forModelClass:[SettingModelKind1 class]];
    [self registerClass:[SettingModelKind1 class] forClickMethod:NSStringFromSelector(@selector(clickCellWithModel:))];
    [self registerClass:[SettingKindCell2 class] forModelClass:[SettingKindModel2 class]];
    [self registerClass:[SettingKindCell3 class] forModelClass:[SettingKindModel3 class]];
    
    [self configDataSource];
}

-(void)configDataSource{
    SettingModelKind1 *item = [[SettingModelKind1 alloc]init];
    item.iconUrl = @"http://d.lanrentuku.com/down/png/1610/16young-avatar-collection/girl-2.png";
    item.leftText = @"个人主页";
    item.method = NSStringFromSelector(@selector(clickPersonZone:));
    [self.dataSource addObject:@[item]];
    
    item = [[SettingModelKind1 alloc]init];
    item.iconUrl = @"http://d.lanrentuku.com/down/png/1610/16young-avatar-collection/girl-2.png";
    item.leftText = @"🙄呵呵";
    [self.dataSource addObject:@[item, item]];
    
    SettingKindModel2 *item2 = [[SettingKindModel2 alloc]init];
    item2.leftText = @"清除缓存";
    item2.method = NSStringFromSelector(@selector(clickCleanCache:));
    item2.rightText = @"20M";
    
    SettingKindModel2 *item3= [[SettingKindModel2 alloc]init];
    item3.leftText = @"意见反馈";
    item3.rightText = @"";
    [self.dataSource addObject:@[item2,item3]];
    
    SettingKindModel3 *item4 = [[SettingKindModel3 alloc]init];
    item4.leftText = @"退出登录";
    item4.method = NSStringFromSelector(@selector(clickLogout:));
    [self.dataSource addObject:@[item4]];
}

#pragma mark - tableViewCell 点击回调

-(void)clickPersonZone:(SettingModelKind1 *)model{
    NSLog(@"%@", [model mj_JSONString]);
}

-(void)clickCellWithModel:(SettingModelKind1 *)model{
    NSLog(@"%@", [model mj_keyValues].description);
}
-(void)clickCleanCache:(SettingKindModel2 *)model{
    NSLog(@"清理缓存");
}

-(void)clickLogout:(SettingKindModel3 *)model{
    NSLog(@"退出登录");
}

#pragma mark - tableView代理事件

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
