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
-(id)push:(NSString *)className withParams:(NSDictionary *)params{
    Class clss = NSClassFromString(className);
    if ([clss isSubclassOfClass:self.superclass]) {
        id viewController = [[clss alloc]init];
        for (NSString *key in params.allKeys) {
            [viewController setValue:params[key] forKey:key];
        }
        [viewController setObject:params forKey:params];
        [self.navigationController pushViewController:viewController animated:YES];
        return viewController;
    }else{
        NSLog(@"%@---%@", NSStringFromSelector(_cmd), className);
    }
    return nil;
}
@end
