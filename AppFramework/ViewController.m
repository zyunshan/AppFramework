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

#import "AudioTool.h"

@interface ViewController ()

@property (nonatomic, strong) AudioTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    __block typeof(self) weakSelf = self;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.view);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.view layoutIfNeeded];
    
    NSLog(@"%@", NSStringFromCGRect(button.frame));
    
    [button setTitle:@"你对他究竟做了什么你对他究竟做了什么" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"local"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    
    
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];

    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH-40, 79)];
    textView.maxInputLength = 20;
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"7143" ofType:@"mp3"];
    self.tool = [[AudioTool alloc]initWithPath:filePath];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    ;
}

-(void)buttonAction:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertWithTitle:@"这是标题" message:@"这是福建信息" style:UIAlertControllerStyleActionSheet cancel:@"取消" others:@[@"item1", @"item2", @"item3", @"item4"] block:^(NSInteger index) {
        [self.tool startPlaying];
        
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
