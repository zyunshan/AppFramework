//
//  BaseWebViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/24.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) UIProgressView *progressView;


@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    if (self.url) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, cs_nav_height, cs_screen_width, 1)];
        _progressView.progressTintColor = self.progressTinColor;
    }
    return _progressView;
}

-(UIColor *)progressTinColor{
    if (_progressTinColor) {
        return _progressTinColor;
    }
    return [UIColor redColor];
}

-(WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc]init];
    }
    return _configuration;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, cs_nav_height, cs_screen_width, cs_screen_height-cs_nav_height) configuration:self.configuration];
        //添加加载进度监听
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    }
    return _webView;
}

#pragma mark - webView 进度监听处理
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress == 1.0) {
            _progressView.alpha = 0;
            self.title = _webView.title;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
