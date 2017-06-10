//
//  UIView+custom.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (custom)

+ (id)initWithOwner:(id)owner;
+ (id)initWithOwner:(id)owner index:(NSUInteger)index;
+ (id)initWithOwner:(id)owner nibName:(NSString *)nibName index:(NSUInteger)index;

- (void)removeAllSubViews;
- (void)removeAllSubViews:(int)tag;
- (void)removeAllSubViews:(int)minTag maxTag:(int)maxTag;

@end

@interface UIView (layer)
-(void)layerWithCornerRadius:(CGFloat)radius;

-(void)layerWithBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

-(void)layerWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

-(void)layerWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;

/**
 添加虚线
 */
-(CAShapeLayer *)dashLayerFrom:(CGPoint)from to:(CGPoint)to width:(CGFloat)width lineWidth:(CGFloat)lineWidth space:(CGFloat)space color:(UIColor *)color;
/**
 添加虚线
 */
-(CAShapeLayer *)dashLayerFrom:(CGPoint)from to:(CGPoint)to width:(CGFloat)width color:(UIColor *)color;

-(void)dashLayerFrom:(CGPoint)from to:(CGPoint)to;
@end
