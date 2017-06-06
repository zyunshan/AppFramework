//
//  VideoTool.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerView : UIView

-(instancetype)initWithFrame:(CGRect)frame sourceURL:(NSURL *)url;

-(void)play;

-(void)stop;

-(void)pause;

@end
