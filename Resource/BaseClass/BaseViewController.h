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
@property (copy, nonatomic) void (^callback)(id value1, id value2);


/**
 从nib加载viewController

 @param className nib对应的viewcontroller 雷明
 @return viewController
 */
-(id)loadNibViewControllerWithClassName:(NSString *)className;
@end
