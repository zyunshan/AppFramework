//
//  VideoToolView.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/7.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "VideoToolView.h"

@interface VideoToolView ()

/**
 播放进度指示条
 */
@property (nonatomic, strong) UIProgressView *progressView;

/**
 播放停止按钮
 */
@property (nonatomic, strong) UIButton *btnPlayOrStop;

/**
 全屏
 */
@property (nonatomic, strong) UIButton *btnFullScreen;

/**
 当前播放时间
 */
@property (nonatomic, strong) UILabel *labelCurrentTime;

/**
 总时间
 */
@property (nonatomic, strong) UILabel *labelTotalTime;

@end

@implementation VideoToolView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

/**
 设置 UI
 */
-(void)setUpUI{
    [self addSubview:self.btnPlayOrStop];
    [self addSubview:self.labelCurrentTime];
    [self addSubview:self.progressView];
    [self addSubview:self.labelTotalTime];
    [self addSubview:self.btnFullScreen];
    
    //布局
    [self.btnPlayOrStop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(0);
        make.width.equalTo(@44);
    }];
    
    //当前时间
    [self.labelCurrentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progress = 1000;
    }
    return _progressView;
}

-(UIButton *)btnPlayOrStop{
    if (!_btnPlayOrStop) {
        _btnPlayOrStop = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnPlayOrStop;
}

-(UILabel *)labelCurrentTime{
    if (!_labelCurrentTime) {
        _labelCurrentTime = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _labelCurrentTime;
}

-(UILabel *)labelTotalTime{
    if (!_labelTotalTime) {
        _labelTotalTime = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _labelTotalTime;
}

-(UIButton *)btnFullScreen{
    if (!_btnFullScreen) {
        _btnFullScreen = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnFullScreen;
}
@end
