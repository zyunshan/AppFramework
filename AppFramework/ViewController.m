//
//  ViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+Custom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    ;
}

-(void)buttonAction:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"这是 tittle" message:@"这是 message 回事做傻事所所所所" preferredStyle:1];
    [alertController addItems:@[@"item0",@"item1",@"item2",@"item3",@"item4",@"item5",@"item6"] block:^(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
