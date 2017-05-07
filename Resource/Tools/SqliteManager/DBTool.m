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
        databaseQueue = dispatch_queue_create("databaseOperationQueue", DISPATCH_QUEUE_CONCURRENT);
        queueInfo = [NSMutableDictionary new];
    }
    return self;
}

-(dispatch_queue_t )queueWithTable:(NSString *)tbName{
    dispatch_queue_t queue = [queueInfo objectForKey:tbName];
    if (!queue) {
        queue = dispatch_queue_create([tbName UTF8String], DISPATCH_QUEUE_SERIAL);
        [queueInfo setObject:queue forKey:tbName];
    }
    return queue;
}

-(void)openDatabase:(NSString *)dbPath{
    int result = sqlite3_open([dbPath UTF8String], &database);
    if (result != SQLITE_OK) {
        NSLog(@"打开或创建数据库失败 %d",result);
    }
    NSLog(@"本地数据路径：%@", dbPath);
}

-(void)closeDatabase{
    if (sqlite3_close(database)!= SQLITE_OK) {
        NSLog(@"关闭数据库失败");
    }else{
        database = NULL;
    }
}

-(void)createTableWithName:(NSString *)tbName withItems:(NSArray <NSString *>*)items primaryKey:(NSString *)key{
    __block NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (", tbName];
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *primary = @"";
        if ([obj isEqualToString:key]) {
            primary = @"primary key";
        }
        sql = [NSString stringWithFormat:@"%@ %@ text default '' %@,", sql,obj,primary];
    }];
    sql = [sql stringByReplacingCharactersInRange:NSMakeRange(sql.length-1, 1) withString:@")"];
    [self execSql:sql tbName:tbName];
}

-(void)insertTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyValues{
    NSString *sql = [self insertTable:tbName keyValues:keyValues];
    [self execSql:sql tbName:tbName];
}

-(void)insertTable:(NSString *)tbName withArray:(NSArray <NSDictionary *> *)array{
    NSMutableArray *transactionSql = [NSMutableArray new];
    for (NSInteger i = 0; i<array.count; i++) {
        NSString *sql = [self insertTable:tbName keyValues:array[i]];
        [transactionSql addObject:sql];
    }
    dispatch_async(databaseQueue, ^{
        dispatch_queue_t queue = [self queueWithTable:tbName];
        dispatch_async(queue, ^{
            [self execInsertTransactionSql:transactionSql];
        });
    });
}

-(void)execInsertTransactionSql:(NSMutableArray *)transactionSql{
    //使用事务，提交插入sql语句
    @try{
        char *errorMsg;
        if (sqlite3_exec(database, "BEGIN", NULL, NULL, &errorMsg)==SQLITE_OK){
            NSLog(@"启动事务成功");
            sqlite3_free(errorMsg);
            sqlite3_stmt *statement;
            for (int i = 0; i<transactionSql.count; i++){
                if (sqlite3_prepare_v2(database,[[transactionSql objectAtIndex:i] UTF8String], -1, &statement,NULL)==SQLITE_OK){
                    if (sqlite3_step(statement)!=SQLITE_DONE) sqlite3_finalize(statement);
                }
            }
            if (sqlite3_exec(database, "COMMIT", NULL, NULL, &errorMsg)==SQLITE_OK){
                NSLog(@"提交事务成功");
            }
            sqlite3_free(errorMsg);
        }
        else sqlite3_free(errorMsg);
    }
    @catch(NSException *e){
        char *errorMsg;
        if (sqlite3_exec(database, "ROLLBACK", NULL, NULL, &errorMsg)==SQLITE_OK)  NSLog(@"回滚事务成功");
        sqlite3_free(errorMsg);
    }
    @finally{}
}

-(NSString *)insertTable:(NSString *)tbName keyValues:(NSDictionary *)keyValues{
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
    return sql;
}

-(void)updateTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyVaules condtions:(NSDictionary *)conditions{
    NSString *sql = [NSString stringWithFormat:@"update %@ set", tbName];
    __block NSString *update = @"";
    [keyVaules enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        update = [NSString stringWithFormat:@"%@ %@='%@' ,", update, key, obj];
    }];
    __block NSString *condition = @"";
    [conditions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        condition = [NSString stringWithFormat:@"%@ %@='%@' and", condition, key, obj];
    }];
    update = [update substringToIndex:update.length-1];
    condition = [condition substringToIndex:condition.length-3];
    sql = [NSString stringWithFormat:@"%@ %@ where %@", sql, update, condition];
    [self execSql:sql tbName:tbName];
}

-(void)deleteTable:(NSString *)tbName conditions:(NSDictionary *)conditions{
    __block NSString *sql = [NSString stringWithFormat:@"delete from %@ where ", tbName];
    [conditions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        sql = [NSString stringWithFormat:@"%@ %@='%@' and", sql, key, obj];
    }];
    sql = [sql substringToIndex:sql.length-3];
    [self execSql:sql tbName:tbName];
}

-(void)searchTable:(NSString *)tbName conditions:(NSDictionary *)conditions completionHandle:(void(^)(NSMutableArray <NSMutableDictionary *>*result))completion{
    __block NSString *sql = [NSString stringWithFormat:@"select * from %@ ", tbName];
    if (conditions) {
        sql = [sql stringByAppendingString:@"where"];
    }
    [conditions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        sql = [NSString stringWithFormat:@"%@ %@='%@' and", sql, key, obj];
    }];
    sql = [sql substringToIndex:sql.length-3];
    dispatch_async(databaseQueue, ^{
        dispatch_queue_t queue = [self queueWithTable:tbName];
        dispatch_async(queue, ^{
           [self searchSql:sql completionHandle:completion];
        });
    });
}

-(void)clenTable:(NSString *)tbName{
    NSString *sql = [NSString stringWithFormat:@"delete from %@", tbName];
    [self execSql:sql tbName:tbName];
}

-(void)dropTable:(NSString *)tbName{
    NSString *sql = [NSString stringWithFormat:@"drop table %@", tbName];
    [self execSql:sql tbName:tbName];
}

-(void)updateTable:(NSString *)tbName withColumnOldToNewKeyValues:(NSDictionary *)keyValues{
//    NSString *sql = [NSString stringWithFormat:@"alter table %@ "]
}

-(void)updateTable:(NSString *)tbName addNewColumns:(NSArray *)columns{
    NSString *sql = [NSString stringWithFormat:@"alert table %@ add ", tbName];
    __block NSString *newColums = @"";
    [columns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        newColums = [NSString stringWithFormat:@"%@ text,", obj];
    }];
    newColums = [newColums substringToIndex:newColums.length-1];
    sql = [sql stringByAppendingString:newColums];
    [self execSql:sql tbName:tbName];
}

-(void)updateTable:(NSString *)tbName removeColumns:(NSArray *)columns{
    NSString *sql = [NSString stringWithFormat:@"alert table %@ drop ", tbName];
    __block NSString *newColums = @"";
    [columns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        newColums = [NSString stringWithFormat:@"%@ ,", obj];
    }];
    newColums = [newColums substringToIndex:newColums.length-1];
    sql = [sql stringByAppendingString:newColums];
    [self execSql:sql tbName:tbName];
}

-(void)execSql:(NSString *)sql tbName:(NSString *)tbName{
    dispatch_async(databaseQueue, ^{
        dispatch_queue_t queue = [self queueWithTable:tbName];
        dispatch_async(queue, ^{
            char *error;
            int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error);
            if (result != SQLITE_OK) {
                NSLog(@"==============\n数据库操作失败失败：%@\n %@\n%s\n==========", tbName, sql, error);
            }
        });
    });
}

-(void)searchSql:(NSString *)sql completionHandle:(void(^)(id result))completion{
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
    NSMutableArray *results = [NSMutableArray new];
    if (result == SQLITE_OK) {
        result = sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *item = [NSMutableDictionary new];
            int columnCount = sqlite3_column_count(stmt);
            for (int i=0; i<columnCount; i++) {
                char *name = (char *)sqlite3_column_name(stmt, i);
                char *text = (char *)sqlite3_column_text(stmt, i);
                NSString *value = [NSString stringWithFormat:@"%s",text];
                NSString *key = [NSString stringWithFormat:@"%s", name];
                [item setObject:value forKey:key];
            }
            [results addObject:item];
        }
        sqlite3_finalize(stmt);
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        completion(results);
    });
}

-(BOOL)isExistTable:(NSString *)tbName{
    NSString *sql = [NSString stringWithFormat:@"select count(*) from sqlite_master where type='table' and name='%@'",tbName];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            int count  = sqlite3_column_int(stmt, 0);
            return count;
        }
    }
    return NO;
}

-(BOOL)isExistInTable:(NSString *)inName conditions:(NSDictionary *)conditions{
    __block NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where ",inName];
    [conditions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        sql = [NSString stringWithFormat:@"%@ %@='%@' and", sql, key, obj];
    }];
    sql = [sql substringToIndex:sql.length - 3];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            int count  = sqlite3_column_int(stmt, 0);
            return count;
        }
    }
    return NO;
}
@end


