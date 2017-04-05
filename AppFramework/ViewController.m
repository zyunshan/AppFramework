//
//  ViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+Custom.h"
#import "AFNetworkHelper.h"
#import "TestModel.h"
#import <AudioToolbox/AudioToolbox.h>

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
    
    __block typeof(self) weakSelf = self;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.view);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.view layoutIfNeeded];
    
    NSLog(@"%@", NSStringFromCGRect(button.frame));
    
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(20);
    }];

    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH-40, 79)];
    textView.maxInputLength = 20;
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    ;
}

-(void)buttonAction:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertWithTitle:@"这是标题" message:@"这是福建信息" style:UIAlertControllerStyleActionSheet cancel:@"取消" others:@[@"item1", @"item2", @"item3", @"item4"] block:^(NSInteger index) {
        
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
