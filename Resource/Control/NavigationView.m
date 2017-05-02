//
//  NavigationView.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#define nav_color_title  [UIColor blackColor]
#define nav_font_title  [UIFont systemFontOfSize:17]
#define nav_font_item   [UIFont systemFontOfSize:15]

#import "NavigationView.h"
#import "UIControl+Button.h"

@interface NavigationView ()

/**
 标题控件
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 底部线
 */
@property (nonatomic, strong) UIView *bottomLineView;

/**
 最近添加的左侧按钮
 */
@property (nonatomic, weak) UIView *lastLeftItem;

/**
 最近添加的右侧按钮
 */
@property (nonatomic, weak) UIView *lastRightItem;

@property (nonatomic, strong) NSMutableArray *leftItems;

@property (nonatomic, strong) NSMutableArray *rightItems;
@end

@implementation NavigationView

-(instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [UIView new];
    }
    return _titleView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = self.titleFont;
        _titleLabel.textColor = self.titleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor redColor];
    }
    return _bottomLineView;
}

-(void)loadUI{
    [self.titleView addSubview:self.titleLabel];
    [self addSubview:self.titleView];
    [self addSubview:self.bottomLineView];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - property

-(NSMutableArray *)leftItems{
    if (!_leftItems) {
        _leftItems = [NSMutableArray new];
    }
    return _leftItems;
}

-(NSMutableArray *)rightItems{
    if (!_rightItems) {
        _rightItems = [NSMutableArray new];
    }
    return _rightItems;
}

-(UIColor *)titleColor{
    if (_titleColor) {
        return _titleColor;
    }
    return nav_color_title;
}

-(UIFont *)titleFont{
    if (_titleFont) {
        return _titleFont;
    }
    return nav_font_title;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setAttributedTitle:(NSMutableAttributedString *)attributedTitle{
    _attributedTitle = attributedTitle;
    self.titleLabel.attributedText = attributedTitle;
}
#pragma mark - function
-(void)addItemWithTitle:(id)title position:(NavItemPostion)postion margin:(CGFloat)margin width:(CGFloat)width block:(void(^)())block{
    if (width == 0) {
        width = 44;
    }
    if (postion == NavItemPostionRight) {
        [self addRightItemWithTitle:title right:margin width:width block:block];
    }else
        [self addLeftItemWithTitle:title left:margin width:width block:block];
}

-(void)addLeftItemWithTitle:(id)title left:(CGFloat)left width:(CGFloat)width block:(void(^)())block{
    UIButton *button = [self itemWithTitle:title block:block];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(44);
    }];
    if (self.lastLeftItem) {
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lastLeftItem.mas_right).offset(left);
        }];
    }else{
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
    }
    self.lastLeftItem = button;
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.lastLeftItem.mas_right).offset(5);
    }];
    [self.leftItems addObject:button];
}

-(void)addRightItemWithTitle:(id)title right:(CGFloat)right width:(CGFloat)width block:(void(^)())block{
    UIButton *button = [self itemWithTitle:title block:block];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(44);
    }];
    if (self.lastRightItem) {
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.lastRightItem.mas_left).offset(right);
        }];
    }else{
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(right);
        }];
    }
    self.lastRightItem = button;
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.greaterThanOrEqualTo(self.lastLeftItem.mas_left).offset(5);
    }];
    [self.rightItems addObject:button];
}

-(UIButton *)itemWithTitle:(id)title block:(void(^)())block{
    UIButton *button = [UIButton new];
    if ([title isKindOfClass:[UIImage class]]) {
        [button setImage:title forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeCenter;
    }
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    button.clickEvent = block;
    return button;
}
@end
