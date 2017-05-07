//
//  BaseViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"
#import "NavigationView.h"

@interface BaseViewController ()

@property (nonatomic, strong) NavigationView *navigationView;
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
    [self.view addSubview:self.navigationView];
    
}

-(NavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, cs_screen_width, cs_nav_height)];
    }
    return _navigationView;
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
-(id)loadNibViewControllerWithClassName:(NSString *)className{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:[UIViewController class]]) {
        id viewController = [[clss alloc]initWithNibName:className bundle:nil];
        return viewController;
    }
    return nil;
}
@end
