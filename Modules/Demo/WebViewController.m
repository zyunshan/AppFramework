//
//  WebViewController.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/22.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<WKScriptMessageHandler>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSString *test = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:test baseURL:nil];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(@64);
        make.bottom.mas_equalTo(-200);
    }];
    
    WKUserContentController *userCC = self.webView.configuration.userContentController;
    
    [userCC addScriptMessageHandler:self name:@"alertMobile"];
    

    [userCC addScriptMessageHandler:self name:@"showMobile"];

}


- (IBAction)btnInput:(id)sender {
    NSString *text = self.textField.text;
    NSString *js = [NSString stringWithFormat:@"alertMobile('%@')", text];
   [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
       
   }];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

    [self btnClick:message.body];
}

-(void)btnClick:(NSString *)msg{
    self.textField.text = msg;
}
@end
