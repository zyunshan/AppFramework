//
//  UIView+custom.m
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "UIView+custom.h"

@implementation UIView (custom)

+ (id)initWithOwner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil] objectAtIndex:0];
}

+ (id)initWithOwner:(id)owner index:(NSUInteger)index
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil] objectAtIndex:index];
}

+ (id)initWithOwner:(id)owner nibName:(NSString *)nibName index:(NSUInteger)index
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:index];
}

- (void)removeAllSubViews:(int)tag
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        if (view.tag == tag) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeAllSubViews:(int)minTag maxTag:(int)maxTag
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        if (view.tag >= minTag && view.tag <= maxTag) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeAllSubViews
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        [view removeFromSuperview];
    }
}

 

@end

@implementation UIView (layer)

-(void)layerWithCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

-(void)layerWithBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

-(void)layerWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    [self layerWithCornerRadius:radius];
    [self layerWithBorderWidth:width borderColor:color];
}

-(void)layerWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

-(CAShapeLayer *)dashLayerFrom:(CGPoint)from to:(CGPoint)to width:(CGFloat)width lineWidth:(CGFloat)lineWidth space:(CGFloat)space color:(UIColor *)color{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:width];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth],
      [NSNumber numberWithInt:space],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y
    CGPathMoveToPoint(path, NULL, from.x, from.y);
    CGPathAddLineToPoint(path, NULL, to.x, to.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    return shapeLayer;
}
-(CAShapeLayer *)dashLayerFrom:(CGPoint)from to:(CGPoint)to width:(CGFloat)width color:(UIColor *)color{
    return [self dashLayerFrom:from to:to width:width lineWidth:4 space:1 color:color];
}

-(void)dashLayerFrom:(CGPoint)from to:(CGPoint)to{
    CAShapeLayer * dashLayer =  [self dashLayerFrom:from to:to width:0.5 color:[UIColor colorWithRed:211.0/255 green:211.0/255 blue:211.0/255 alpha:1]];
    [self.layer addSublayer:dashLayer];
}
@end
