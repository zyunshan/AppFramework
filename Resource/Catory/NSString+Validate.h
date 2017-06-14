//
//  NSString+Validate.h
//  APP
//
//  Created by huanchi on 15/12/22.
//  Copyright © 2015年 上海欢炽网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

//账号
BOOL validateAccount(NSString *account);

//邮箱
BOOL validateEmail(NSString *email);

//手机
BOOL validateMobile(NSString *mobile);

//用户名
BOOL validateUserName(NSString *userName);

//密码
BOOL validatePassword(NSString *password);

//昵称
BOOL validateNickName(NSString *nickName);

//身份证号
BOOL validateIdentityCard(NSString *identityCard);

BOOL validateEmpty(NSString *text);
@end
