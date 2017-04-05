//
//  UpdateManager.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "UpdateManager.h"

@implementation UpdateManager

+(instancetype)shareManager{
    static UpdateManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UpdateManager alloc]init];
    });
    return manager;
}
-(NSDictionary *)appInfo{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

-(NSString *)appVersion{
    return [self.appInfo objectForKey:@"CFBundleShortVersionString"];
}

-(void)checkForUpdateWithResult:(void(^)(BOOL isNeedUpdate, NSString *newVersion))success failure:(void(^)(NSString *errMsg))failure{

}
@end
