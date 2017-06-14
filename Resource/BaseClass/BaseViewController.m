//
//  BaseViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary new];
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationView];
    [self setIsShowBackBtn:YES];
}

-(NavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, cs_screen_width, cs_nav_height)];
    }
    return _navigationView;
}

-(void)setIsShowBackBtn:(BOOL)isShowBackBtn{
    if (isShowBackBtn) {
        __block typeof(self) weakSelf = self;
        [self.navigationView addItemWithTitle:[UIImage imageNamed:@"nav_back"] position:NavItemPostionLeft margin:0 width:0 block:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitle:(NSString *)title{
    self.navigationView.title = title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(id)loadNibVCWithClassName:(NSString *)className{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:[UIViewController class]]) {
        id viewController = [[clss alloc]initWithNibName:className bundle:nil];
        return viewController;
    }
    return nil;
}

-(id)push:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(void (^)(id value, ...))callback{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:[UIViewController class]]) {
        BaseViewController *viewController = [[clss alloc]init];
        for (NSString *key in params.allKeys) {
            [viewController setValue:params[key] forKey:key];
        }
        [viewController setValue:@YES forKey:@"hidesBottomBarWhenPushed"];
        viewController.callback = callback;
        [self.navigationController pushViewController:viewController animated:animated];
        return viewController;
    }
    return nil;
}

-(id)present:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(void (^)(id value, ...))callback{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:[UIViewController class]]) {
        BaseViewController *viewController = [[clss alloc]init];
        for (NSString *key in params.allKeys) {
            [viewController setValue:params[key] forKey:key];
        }
        viewController.callback = callback;
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:viewController];
        [self presentViewController:nav animated:animated completion:nil];
        return viewController;
    }
    return nil;
}

-(id)show:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(void (^)(id value , ...))callback{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:[BaseViewController class]]) {
        BaseViewController * viewController = [[clss alloc]init];
        for (NSString *key in params.allKeys) {
            [viewController setValue:params[key] forKey:key];
        }
        [viewController setValue:@(UIModalPresentationOverFullScreen) forKey:@"modalPresentationStyle"];
        [self presentViewController:viewController animated:animated completion:nil];
        viewController.callback = callback;
        return viewController;
    }
    return nil;
}
-(id)popToViewController:(NSString *)className animated:(BOOL)animated{
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *viewController in viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            [self.navigationController popToViewController:viewController animated:animated];
            return viewController;
        }
    }
    return nil;
}

@end
