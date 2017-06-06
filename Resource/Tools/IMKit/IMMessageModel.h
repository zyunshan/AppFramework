//
//  MessageModel.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMUserModel;
@class IMMessageContentModel;

@interface IMMessageBaseModel : NSObject

/**
 消息 id
 */
@property (nonatomic, copy)  NSString *targetId;

/**
 消息内容
 */
@property (strong, nonatomic) IMMessageContentModel *messageContent;

/**
 发送者信息
 */
@property (strong, nonatomic) IMUserModel *sendUser;

@end



@interface IMMessageContentModel : NSObject

/**
 消息对象 id
 */
@property (nonatomic, copy) NSString *targetId;

/**
 消息 id
 */
@property (nonatomic, assign) NSInteger messageId;

/**
 时间戳
 */
@property (nonatomic, assign) double timestamp;

@end

#pragma mark - 文字消息

/**
 文字消息
 */
@interface IMTextMessageModel : IMMessageContentModel

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *extra;

@end

#pragma mark - 用户

/**
 用户信息
 */
@interface IMUserModel : NSObject


/**
 用户 id
 */
@property (nonatomic, copy) NSString *uid;

/**
 头像
 */
@property (nonatomic, copy) NSString *portraitUrl;

/**
  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 附加信息
 */
@property (nonatomic, copy) NSString *extra;

@end
