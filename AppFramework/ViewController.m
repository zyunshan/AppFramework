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
#import <AudioToolbox/AudioToolbox.h>

#import "AudioTool.h"
#import "NavigationView.h"
#import "CycleView.h"

@interface ViewController ()

@property (nonatomic, strong) AudioTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    __block typeof(self) weakSelf = self;
    [self.navigationView addItemWithTitle:@"demo" position:1 margin:-10 width:50 block:^{
        [weakSelf push:@"DemoViewController" params:nil animated:YES callback:nil];
    }];
}


@end
