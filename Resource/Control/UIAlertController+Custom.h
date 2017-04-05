//
//  UIAlertController+Custom.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Custom)

/**
 添加默认的样式
 */
-(void)addItems:(NSArray <NSString *>*)items block:(void(^)(NSInteger index))block;

/**
 添加指定样式

 */
-(void)addItem:(NSString *)item style:(UIAlertActionStyle)style block:(void(^)())block;


/**
 UIAlertController 传入字符串初始化

 @param block 点击对应的 item 的索引
 */
+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel others:(NSArray <NSString *> *)others block:(void (^)(NSInteger index))block;

/**
 UIAlertController 传入字典或 model 对象初始化
 
 @param others 内容可以是对象
 @param key 如果是对象则是对应的 key
 @param block 点击对应的 item 的索引
 */
+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel others:(NSArray *)others objectForKey:(NSString *)key block:(void (^)(NSInteger index, id obj))block;
@end
