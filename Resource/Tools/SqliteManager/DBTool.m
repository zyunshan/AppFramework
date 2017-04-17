//
//  DBTool.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/17.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "DBTool.h"
#import "NSObject+Parser.h"

@implementation DBTool

+(instancetype)tool{
    static DBTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[DBTool alloc]init];
    });
    return tool;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)openDatabase:(NSString *)dbPath{
    int result = sqlite3_open([dbPath UTF8String], &database);
    if (result != SQLITE_OK) {
        NSLog(@"打开或创建数据库失败 %d",result);
    }
    NSLog(@"本地数据路径：%@", dbPath);
}

-(void)createTableWithName:(NSString *)tbName withItems:(NSArray <NSString *>*)items primaryKey:(NSString *)key{
    __block NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (", tbName];
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *primary = @"";
        if ([obj isEqualToString:key]) {
            primary = @"primary key";
        }
        sql = [NSString stringWithFormat:@"%@ %@ text %@,", sql,obj,primary];
    }];
    sql = [sql stringByReplacingCharactersInRange:NSMakeRange(sql.length-1, 1) withString:@")"];
    [self execSql:sql method:_cmd];
}

-(void)insertTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyValues{
    NSString *sql = [NSString stringWithFormat:@"insert into %@ ", tbName];
    __block NSString *keys = @"(";
    __block NSString *values = @"values(";
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        keys = [NSString stringWithFormat:@"%@%@ ,", keys, key];
        values = [NSString stringWithFormat:@"%@ '%@' ,",values, obj];
    }];
    keys = [keys stringByReplacingCharactersInRange:NSMakeRange(keys.length-1, 1) withString:@")"];
    values = [values stringByReplacingCharactersInRange:NSMakeRange(values.length-1, 1) withString:@")"];
    sql = [NSString stringWithFormat:@"%@ %@ %@", sql, keys, values];
    [self execSql:sql method:_cmd];
}

-(void)updateTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyVaules forKey:(NSString *)key andValue:(NSString *)value{
    NSString *sql = [NSString stringWithFormat:@"update %@ set", tbName];
    __block NSString *update = @"";
    [keyVaules enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        update = [NSString stringWithFormat:@"%@ %@='%@' ,", update, key, obj];
    }];
    update = [update substringToIndex:update.length-1];
    sql = [NSString stringWithFormat:@"%@ %@ where %@='%@'", sql, update, key, value];
    [self execSql:sql method:_cmd];
}

-(void)deleteTable:(NSString *)tbName forKey:(NSString *)key andValue:(NSString *)value{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@='%@'", tbName, key, value];
    [self execSql:sql method:_cmd];
}

-(void)searchTable:(NSString *)tbName forKeyValues:(NSDictionary *)keyValues completionHandle:(void(^)(id result))completion{
    __block NSString *sql = [NSString stringWithFormat:@"select * from %@ ", tbName];
    if (keyValues) {
        sql = [sql stringByAppendingString:@"where"];
    }
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        sql = [NSString stringWithFormat:@"%@ %@='%@' and", sql, key, obj];
    }];
    sql = [sql substringToIndex:sql.length-3];
    [self searchSql:sql completionHandle:completion];
}

-(void)execSql:(NSString *)sql method:(SEL)method{
    char *error;
    int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"==============\n数据库操作失败失败：%@\n %@\n%s\n==========", NSStringFromSelector(method), sql, error);
    }
}

-(void)searchSql:(NSString *)sql completionHandle:(void(^)(id result))completion{
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        NSMutableArray *results = [NSMutableArray new];
        result = sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *item = [NSMutableDictionary new];
            char *name = (char *)sqlite3_column_text(stmt, 10);
//            const char  *test = (char *)sqlite3_column_origin_name(stmt, 2);
            NSLog(@"%s", name);
        }
    }
}
@end


