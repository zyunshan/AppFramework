//
//  BaseWebViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/24.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "BaseViewController.h"

/**
 app 内网页浏览
 */
@interface BaseWebViewController : BaseViewController

//网页加载进度条颜色
@property (strong, nonatomic) UIColor *progressTinColor;

#pragma mark - require
//网页地址
@property (copy, nonatomic) NSString *url;

@end
