//
//  DBManager.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/17.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DBManager.h"
#import "DBTool.h"
#import <objc/runtime.h>

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
        cacheInfo = [NSMutableDictionary new];
    }
    return self;
}

-(NSString *)path{
    NSArray *cacheArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [cacheArray firstObject];
    NSString *path = [documentPath stringByAppendingPathComponent:dbPath];
    return path;
}

-(void)creatTableWithClass:(Class)clss primaryKey:(NSString *)key{
    NSArray *properties = [self propertyListOfClass:clss];
    [[DBTool tool] createTableWithName:NSStringFromClass(clss) withItems:properties primaryKey:key];
}

-(void)insertModel:(id)model{
    NSString *className = NSStringFromClass([model class]);
    NSArray *properties = [cacheInfo objectForKey:className];
    if (!properties) {
        properties = [self propertyListOfClass:[model class]];
    }
    [[DBTool tool] insertTable:className withKeyValues:[model mj_keyValues]];
}

- (void)deleteModelFromTable:(NSString *)tbName condition:(NSDictionary *)conditions{
    [[DBTool tool]deleteTable:tbName conditions:conditions];
}

-(void)updateModel:(id)model condition:(NSDictionary *)conditions{
    NSString *className = NSStringFromClass([model class]);
    NSDictionary *keyValues;
    if (![model isKindOfClass:[NSDictionary class]]) {
        keyValues = [model mj_keyValues];
    }
    [[DBTool tool] updateTable:className withKeyValues:keyValues condtions:conditions];
}

-(void)seachFromTable:(NSString *)tbName condition:(NSDictionary *)conditions completionHandle:(void (^)(NSMutableArray *))completion{
    
    void (^searchResult)(id results) = ^(NSMutableArray *results){
        Class clss = NSClassFromString(tbName);
        NSMutableArray *info = [clss mj_objectArrayWithKeyValuesArray:results];
        completion(info);
    };
    [[DBTool tool] searchTable:tbName conditions:conditions completionHandle:searchResult];
}

#pragma mark - objc_runtime



-(NSArray *)propertyListOfClass:(Class)clss{
    //获取属性列表
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (const objc_property_t *p=properties; p < properties+outCount; p++) {
        objc_property_t property = *p;
        const char *name = property_getName(property);
        [data addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    
    //获取父类属性列表
    if (clss.superclass == [NSBundle mainBundle]) {
        [data addObjectsFromArray:[self propertyListOfClass:[clss superclass]]];
    }
    [cacheInfo setObject:data forKey:NSStringFromClass(clss)];
    return data;
}


-(void)openDatabase{
    [[DBTool tool] openDatabase:[self path]];
}

-(void)closeDatabase{
    [[DBTool tool] closeDatabase];
}
@end
