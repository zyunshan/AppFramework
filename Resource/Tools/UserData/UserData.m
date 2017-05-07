//
//  UserData.m
//  AppFramework
//
//  Created by cnsunrun on 2017/3/31.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "UserData.h"

NSString * const App_UserData = @"用户信息";

@implementation UserData

+(instancetype)shareData{
    static UserData *userData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userData = [[UserData alloc]init];
    });
    return userData;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:App_UserData];
        userInfo = [[NSMutableDictionary alloc]initWithDictionary:dic];
    }
    return self;
}

-(id)userDataOfClass:(Class)clss{
    if (!userModel) {
        userModel = [clss mj_objectWithKeyValues:userInfo];
    }
    return userModel;
}

-(void)updateUserDataWithInfo:(id)info{
    if ([info isKindOfClass:[NSDictionary class]]) {
        [userInfo addEntriesFromDictionary:info];
    }else{
        [userInfo addEntriesFromDictionary:[info mj_keyValues]];
    }
    [self save];
}

-(void)logout:(BOOL)clean{
    if (clean) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:App_UserData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [userInfo removeAllObjects];
        userModel = nil;
    }
}

-(void)save{
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:App_UserData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

BOOL isLogin(){
    return YES;
}
@end
