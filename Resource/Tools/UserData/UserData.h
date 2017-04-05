//
//  UserData.h
//  AppFramework
//
//  Created by cnsunrun on 2017/3/31.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const App_UserData;


@interface UserData : NSObject
{
    id userModel;
    NSMutableDictionary *userInfo;
}
+(instancetype)shareData;


/**
 获取用户信息
 */
-(id)userData;

/**
 更新用户信息

 */
-(void)updateUserDataWithInfo:(id)info;

/**
 退出登录

 @param clean 是否清理用户数据， YES 清除本地缓存用户信息， NO 不清理
 */
-(void)logout:(BOOL)clean;

/**
 是否登录
 */
BOOL isLogin();
@end
