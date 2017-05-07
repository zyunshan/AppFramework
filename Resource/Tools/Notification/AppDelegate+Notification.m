//
//  AppDelegate+Notification.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/5.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "AppDelegate+Notification.h"

@implementation AppDelegate (Notification)

-(void)registerRemoteNotification{
    
#ifdef __IPHONE_8_0
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil]];
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
#endif
}

-(void)dealWithLaunchOptions:(NSDictionary *)launchOptions{

}


-(void)dealWithRemoteNotificaiton:(NSDictionary *)userInfo{
    
}

#pragma mark - 注册推送

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    NSLog(@"%@---%@", token, deviceToken.description);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"\n----------------------注册远程推送失败\n");
}


/**
 收到远程推送
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // userInfo为远程推送的内容
    [self dealWithRemoteNotificaiton:userInfo];
}


/**
 收到本地推送
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

@end

@implementation AppDelegate (Test)

+(void)test_receiveNotificationWithType:(NSInteger)type{
    
}

@end
