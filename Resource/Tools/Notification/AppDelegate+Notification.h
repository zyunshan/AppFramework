//
//  AppDelegate+Notification.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Notification)

/**
 注册远程推送
 */
-(void)registerRemoteNotification;


/**
 点击推送消息启动应用
 */
-(void)dealWithLaunchOptions:(NSDictionary *)launchOptions;


/**
 点击推送消息唤醒应用，或者应用内收到推送消息
 */
-(void)dealWithRemoteNotificaiton:(NSDictionary *)userInfo;

@end

@interface AppDelegate (Test)

/**
  测试收到推送
 */
+(void)test_receiveNotificationWithType:(NSInteger)type;
@end
