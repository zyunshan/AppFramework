//
//  NSString+Validate.m
//  APP
//
//  Created by huanchi on 15/12/22.
//  Copyright © 2015年 上海欢炽网络科技有限公司. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

BOOL validateAccount(NSString *account){
    NSString *regex = @"^[A-Za-z0-9]{6,13}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:account];
}

//邮箱
BOOL validateEmail(NSString *email){
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
}

//手机
BOOL validateMobile(NSString *mobile){
    //手机号以13， 15，15,18开头，八个 \d 数字字符
    NSString *regex = @"^1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:mobile];
}

//用户名
BOOL validateUserName(NSString *userName){
    NSString *regex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [userNamePredicate evaluateWithObject:userName];
}

//密码
BOOL validatePassword(NSString *password){
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

//昵称
BOOL validateNickName(NSString *nickName){
    NSString *regex = @"^[\u4e00-\u9fa5]{1,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [passWordPredicate evaluateWithObject:nickName];
}

//身份证号
BOOL validateIdentityCard(NSString *identityCard){
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


@end
