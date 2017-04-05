//
//  AudioTool.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTool : NSObject

-(instancetype)initWithPath:(NSString *)path;

-(void)startPlaying;

-(void)stopPlaying;
@end
