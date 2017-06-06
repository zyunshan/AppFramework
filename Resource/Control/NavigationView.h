//
//  NavigationView.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavItemPostion) {
    NavItemPostionLeft = 0,
    NavItemPostionRight
};

@interface NavigationView : UIView

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题视图，用于自定义
 */
@property (nonatomic, strong) UIView *titleView;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
  富文本标题
 */
@property (nonatomic, copy) NSMutableAttributedString *attributedTitle;

/**
 添加按钮

 @param title 按钮标题
 @param postion 按钮的位置，在标题左侧或者右侧默认左侧
 @param margin 距离左侧或右侧的距离
 @param width 按钮的宽度 若为0 则自适应宽度
 @param block 点击事件回调
 */
-(void)addItemWithTitle:(id)title position:(NavItemPostion)postion margin:(CGFloat)margin width:(CGFloat)width block:(void (^)())block;
@end
