//
//  BaseViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"

typedef void(^Callback)(id);

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NavigationView *navigationView;


/**
 是否显示返回按钮 默认 YES
 */
@property (nonatomic, assign) BOOL isShowBackBtn;
/**
 可作为用于传递参数 或者用于存放网络请求参数
 */
@property (strong, nonatomic) NSMutableDictionary *params;

/**
 用于回调传递参数
 */
@property (copy, nonatomic) Callback callback;


/**
 从nib加载viewController
 */
-(id)loadNibVCWithClassName:(NSString *)className;

/**
 viewController 之间push 方式跳转
 */
-(id)push:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(Callback)callback;

/**
 viewController 之间 present 方式跳转
 */
-(id)present:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(Callback)callback;


/**
 自定义 alertController
 */
-(id)show:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated callback:(Callback)callback;

/**
 返回到指定类型的 viewController
 */
-(id)popToViewController:(NSString *)className animated:(BOOL)animated;

@end
