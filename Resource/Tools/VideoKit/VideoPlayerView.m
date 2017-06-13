//
//  VideoTool.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "VideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerView ()
{
    double totalTime; //总播放时间
}

@property (nonatomic, strong) AVPlayer *player;

/**
 播放视图展示 layer
 */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

/**
 资源对象
 */
@property (nonatomic, strong) AVPlayerItem *playerItem;

/**
 视频地址
 */
@property (nonatomic, strong) NSURL *url;

/**
 播放时间观察者
 */
@property (nonatomic, strong) id playbackTimeObserver;


@end

@implementation VideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame sourceURL:(NSURL *)url{
    self = [super initWithFrame:frame];
    if (self) {
        self.url = url;
        [self.layer addSublayer:self.playerLayer];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
    }
    return _player;
}

-(AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _playerLayer.bounds = self.bounds;
        _playerLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    return _playerLayer;
}

-(AVPlayerItem *)playerItem{
    if (!_playerItem) {
        _playerItem = [[AVPlayerItem alloc]initWithURL:self.url];
        totalTime = CMTimeGetSeconds(_playerItem.asset.duration);
    }
    return _playerItem;
}

/**
 添加观察者
 */
-(void)addObserver{
    
    //添加时间观察
    __block double total = totalTime;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float second = CMTimeGetSeconds(time);
        NSLog(@"当前已经播放%.2f/%.2f.", second, total);
    }];
    
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //添加缓冲进度监听
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserver{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:self.playbackTimeObserver];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            totalTime = CMTimeGetSeconds(playerItem.duration);
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }

}

#pragma mark - 操作

/**
 开始
 */
-(void)play{
    [self addObserver];
    [self.player play];
}

/**
  停止
 */
-(void)stop{
    
}

/**
 暂停
 */
-(void)pause{
    [self.player pause];
}
@end
