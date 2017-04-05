//
//  AudioTool.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "AudioTool.h"
#import <AudioToolbox/AudioToolbox.h>


#define kNumberOfBuffers 3              //AudioQueueBuffer数量，一般指明为3
#define kAQBufSize 128 * 1024           //每个AudioQueueBuffer的大小
#define kAudioFileBufferSize 2048       //文件读取数据的缓冲区大小
#define kMaxPacketDesc 512              //最大的AudioStreamPacketDescription个数

#define NUM_BUFFERS 3
static UInt32 bufferSize=0x10000;//It muse be pow(2,x)

@interface AudioTool ()
{
    //AudioFileStreamID 实例，用于 AudioFileStream 解析
    AudioFileStreamID  audioFileStreamID;
    //音频描述对象,保存音频文件相关信息
    AudioStreamBasicDescription ASBD;
    //AudioQueueBuffer 引用数组
    AudioQueueBufferRef buffers[NUM_BUFFERS];
    //标记当前的 AudioQueueBuffer 是否在使用
    BOOL inuse[kNumberOfBuffers];
    //AudeioQueue 引用实例
    AudioQueueRef audioQueueRef;
}
@end

@implementation AudioTool

-(instancetype)initWithPath:(NSString *)path{
    self = [super init];
    if (self) {

    }
    return self;
}




-(void)startPlaying{
    if (audioFileStreamID == NULL) {
        AudioFileStreamOpen((__bridge void *)self, inPropertyListenerProc, inPacketsProc, 0, &audioFileStreamID);
    }
}

void inPropertyListenerProc(
                                          void *							inClientData,
                                          AudioFileStreamID				inAudioFileStream,
                                          AudioFileStreamPropertyID		inPropertyID,
                                          AudioFileStreamPropertyFlags *	ioFlags){

}

void inPacketsProc(
                   void *							inClientData,
                   UInt32							inNumberBytes,
                   UInt32							inNumberPackets,
                   const void *					inInputData,
                   AudioStreamPacketDescription	*inPacketDescriptions){

}

-(void)stopPlaying{
//    AudioQueueStop(queue, YES);
}
@end
