//
//  BaseViewController.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 可作为用于传递参数 或者用于存放网络请求参数
 */
@property (strong, nonatomic) NSMutableDictionary *params;

/**
 用于回调传递参数
 */
@property (copy, nonatomic) void (^callback)(id model);


/**
 跳转到下一个视图控制器

 @param className 控制器类名
 @param params 控制器对应的 {property : value}
 */
-(id)push:(NSString *)className params:(NSDictionary *)params;

/**
 viewController 之间push 方式跳转
 */
-(id)push:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated;

/**
 viewController 之间 present 方式跳转
 */
-(id)present:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated;


/**
 自定义 alertController
 */
-(id)show:(NSString *)className animated:(BOOL)animated;

/**
 返回到指定类型的 viewController
 
 @param className  指定 viewController的类型
 */
-(id)popToViewController:(NSString *)className animated:(BOOL)animated;



@end
