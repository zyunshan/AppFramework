//
//  DemoTestViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DemoTestViewController.h"
#import "VideoPlayerView.h"


@interface DemoTestViewController ()

@property (nonatomic, strong) VideoPlayerView *playerView;
@end

@implementation DemoTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.type) {
        case DemoTypeVideo:
            [self testVideo];
            break;
            
        default:
            break;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark - video

-(void)testVideo{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.playerView = [[VideoPlayerView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200) sourceURL:url];
    [self.view addSubview:self.playerView];
}

-(void)handleTap:(UITapGestureRecognizer *)tap{
    [self.playerView play];
}
@end
