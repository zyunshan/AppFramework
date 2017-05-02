//
//  IMGScaleView.m
//  DogFoodApp
//
//  Created by cnsunrun on 2017/2/22.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import "IMGScaleView.h"

@interface IMGScaleView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end

@implementation IMGScaleView

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
        self.backgroundColor = [UIColor blackColor];
        
        CGSize size = image.size;
        CGFloat maxWidth = cs_screen_width;
        CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat minscale = MIN(maxWidth/size.width, maxHeight/size.height);
        CGFloat maxscale = MAX(maxWidth/size.width, maxHeight/size.height);
        self.scrollView.minimumZoomScale = minscale;
        self.scrollView.maximumZoomScale = maxscale;
        UITapGestureRecognizer *recongzier = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:recongzier];
        [self.scrollView setZoomScale:minscale];
    }
    return self;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:self.image];
    }
    return _imageView;
}

#pragma mark UIScrollViewDelegate


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = self.imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width) {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height) {
        centerPoint.y = boundsSize.height/2;
    }
    
    self.imageView.center = centerPoint;
}

+(void)showWithView:(UIView *)view andImage:(UIImage *)image{
    IMGScaleView *scanView = [[IMGScaleView alloc]initWithFrame:[UIScreen mainScreen].bounds andImage:image];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:scanView];
}

-(void)handleTap:(UITapGestureRecognizer *)recongizer{
    [self removeFromSuperview];
}
@end
