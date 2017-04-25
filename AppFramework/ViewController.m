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
#import "UIImage+Custom.h"
#import "NavigationView.h"

@interface ViewController ()

@property (nonatomic, strong) AudioTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NavigationView *navView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:navView];
    navView.title = @"这是个测试";
    
    navView.backgroundColor = [UIColor whiteColor];
    navView.titleView.backgroundColor = [UIColor blueColor];
    
    [navView addItemWithTitle:@"left" position:0 margin:0 width:0 block:^{
        NSLog(@"1111");
    }];
    
    [navView addItemWithTitle:@"left-2" position:0 margin:10 width:90 block:nil];
}

- (void)viewWillAppear:(BOOL)animated{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    ;
}


@end
