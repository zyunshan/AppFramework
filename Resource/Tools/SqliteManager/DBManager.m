//
//  DBManager.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/17.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DBManager.h"
#import "DBTool.h"

static NSString *dbPath = @"db.sqlite";

@implementation DBManager

+(instancetype)manager{
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [[DBTool tool] openDatabase:[self path]];
    }
    return self;
}

-(NSString *)path{
    NSArray *cacheArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [cacheArray firstObject];
    NSString *path = [documentPath stringByAppendingPathComponent:dbPath];
    return path;
}
@end
