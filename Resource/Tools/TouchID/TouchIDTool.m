//
//  TouchIDTool.m
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "TouchIDTool.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation TouchIDTool

+(void)authenticate:(void(^)())succ error:(void (^)(NSString *errMsg))failure{
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    NSString* result = @"Authentication is needed to access your notes.";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹识别
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                //验证成功，主线程处理UI
                succ();
            }
            else
            {
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //切换到其他APP，系统取消验证Touch ID
                        failure(@"Authentication was cancelled by the system");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        failure(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        failure(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        failure(@"TouchID is not Avaliable");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }else{
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                failure(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                failure(@"A passcode has not been set");
                break;
            }
            default:
            {
                failure(@"TouchID not available");
                break;
            }
        }
        NSLog(@"%@",error.localizedDescription);
    }
}
@end
