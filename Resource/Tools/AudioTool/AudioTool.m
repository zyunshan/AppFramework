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
static UInt32 gBufferSizeBytes=0x10000;

@interface AudioTool ()
{
    //播放音频文件
    AudioFileID audioFile;
    //音频队列
    AudioQueueRef audioQueue;
}
@end

@implementation AudioTool

-(instancetype)initWithPath:(NSString *)path{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL fileURLWithPath:path];
        CFURLRef urlRef = (__bridge CFURLRef)url;
        OSStatus status = AudioFileOpenURL(urlRef, kAudioFileReadPermission, 0, &audioFile);
        if (status != noErr) {
            NSLog(@"打开文件失败:%@", path);
        }
        
        UInt32 ioDataSize;
        AudioStreamBasicDescription dataFormat;
        //获取音频数据格式
        AudioFileGetProperty(audioFile, kAudioFilePropertyDataFormat, &ioDataSize, &dataFormat);
        //创建播放队列
        status = AudioQueueNewOutput(&dataFormat, audioQueueOutputCallback, (__bridge void*)self, nil, nil, 0, &audioQueue);
        
        UInt32 packetMaxSize;
        UInt32 propertySize;
        /*
          audioFile（类型是 AudioFileID）代表你要播放的音频文件
          kAudioFilePropertyPacketSizeUpperBound 属性ID，用于在音频文件中获取数据包大小的保守上限
          propertySize kAudioFilePropertyPacketSizeUpperBound对应属性大小
          packetMaxSize 播放的音频文件数据包大小的保守上限
         */
        AudioFileGetProperty(audioFile, kAudioFilePropertyPacketSizeUpperBound, &propertySize, &packetMaxSize);
    }
    return self;
}

void audioQueueOutputCallback(
                              void * __nullable       inUserData,
                              AudioQueueRef           inAQ,
                              AudioQueueBufferRef     inBuffer){
    AudioTool *audioTool = (__bridge AudioTool *)inUserData;
    [audioTool audioQueueRef:inAQ fillWithBuffer:inBuffer];
}

-(void)audioQueueRef:(AudioQueueRef)queue fillWithBuffer:(AudioQueueBufferRef)buffer{
//    UInt32 ioNumBytes;
    
//    AudioFileReadPacketData(audioFile, NO, &ioNumBytes, <#AudioStreamPacketDescription * _Nullable outPacketDescriptions#>, <#SInt64 inStartingPacket#>, <#UInt32 * _Nonnull ioNumPackets#>, <#void * _Nullable outBuffer#>)
}

-(void)startPlaying{
    AudioQueueStart(audioQueue, 0);
}

-(void)stopPlaying{
//    AudioQueueStop(queue, YES);
}
@end
