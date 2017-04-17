//
//  DBTool.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/17.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBTool : NSObject
{
    sqlite3 *database;
}
+(instancetype)tool;

/**
 打开数据库，如果不存在则创建

 @param dbPath 数据库地址
 */
-(void)openDatabase:(NSString *)dbPath;


/**
 创建表，如果不存在则创建

 @param tbName 表名
 @param items 表中的字段
 @param key 主键
 */
-(void)createTableWithName:(NSString *)tbName withItems:(NSArray <NSString *>*)items primaryKey:(NSString *)key;

/**
 插入数据库

 @param tbName 插入的表名
 @param keyValues 插入的数据名
 */
-(void)insertTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyValues;

/**
 更新数据库

 @param tbName 表名
 @param keyVaules  要更改的数据
 @param key 关键字段
 @param value 符合的值
 */
-(void)updateTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyVaules forKey:(NSString *)key andValue:(NSString *)value;

/**
 根据筛选条件删除记录

 @param tbName 操作的表名
 @param key 关键字段
 @param value 符合的值
 */
-(void)deleteTable:(NSString *)tbName forKey:(NSString *)key andValue:(NSString *)value;

/**
 数据库查询操作

 @param tbName 操作的表名
 @param keyValues  查询的关键字段 如果是 nil 则查询全部
 */
-(void)searchTable:(NSString *)tbName forKeyValues:(NSDictionary *)keyValues completionHandle:(void(^)(id result))completion;
@end

