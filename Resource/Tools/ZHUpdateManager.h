//
//  ZHUpdateManager.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHUpdateManager : NSObject

+(instancetype)shareManager;

/**
 获取 app Info.plist 文件信息

 @return  info.plist 信息
 */
-(NSDictionary *)appInfo;

/**
 获取 APP 当前的版本号

 @return  app 版本号
 */
-(NSString *)appVersion;

/**
 检查是否需要更新

 @param success 请求成功回调
 @param failure 请求遇到错误回调
 */
-(void)checkForUpdateWithResult:(void(^)(BOOL isNeedUpdate, NSString *newVersion))success failure:(void(^)(NSString *errMsg))failure;
@end
