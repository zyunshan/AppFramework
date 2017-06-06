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

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) NSURL *url;

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
        _player = [AVPlayer playerWithURL:self.url];
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

-(AVPlayerItem *)playerItemWithURL:(NSURL *)url{
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:url];
    return playerItem;
}

#pragma mark - 操作

/**
 开始
 */
-(void)play{
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

}
@end
