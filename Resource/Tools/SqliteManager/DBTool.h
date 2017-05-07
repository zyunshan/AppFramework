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
    dispatch_queue_t  databaseQueue; //数据库操作队列，不同表之间操作并行
    NSMutableDictionary *queueInfo; //针对没个表创建唯一的队列，队列中所有操作串行执行
}
+(instancetype)tool;

/**
 打开数据库，如果不存在则创建

 @param dbPath 数据库地址
 */
-(void)openDatabase:(NSString *)dbPath;

/**
 关闭数据库
 */
-(void)closeDatabase;

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
 批量插入数据库

 @param tbName 操作的表名
 @param array  插入的数据
 */
-(void)insertTable:(NSString *)tbName withArray:(NSArray <NSDictionary *> *)array;

/**
 更新数据库

 @param tbName 表名
 @param keyVaules  要更改的数据
 @param conditions 条件
 */
-(void)updateTable:(NSString *)tbName withKeyValues:(NSDictionary *)keyVaules condtions:(NSDictionary *)conditions;

/**
 根据筛选条件删除记录

 @param tbName 操作的表名
 @param conditions 帅选条件
 */
-(void)deleteTable:(NSString *)tbName conditions:(NSDictionary *)conditions;

/**
 数据库查询操作

 @param tbName 操作的表名
 @param conditions  查询的关键字段 如果是 nil 则查询全部
 */
-(void)searchTable:(NSString *)tbName conditions:(NSDictionary *)conditions completionHandle:(void(^)(NSMutableArray <NSMutableDictionary *>*result))completion;


/**
 清空表

 @param tbName 表名
 */
-(void)clenTable:(NSString *)tbName;

/**
 删除表

 @param tbName  表名
 */
-(void)dropTable:(NSString *)tbName;

/**
  更新表中的字段 sqlite 暂不支持

 @param tbName 表名
 @param keyValues 要修改的字段 旧的 : 新的
 */
-(void)updateTable:(NSString *)tbName withColumnOldToNewKeyValues:(NSDictionary *)keyValues __deprecated;

/**
 新增字段

 @param tbName 操作表名
 @param columns 新增字段
 */
-(void)updateTable:(NSString *)tbName addNewColumns:(NSArray *)columns;

/**
 删除字段  sqlite 暂不支持

 @param tbName 操作表名
 @param columns 要删除的字段
 */
-(void)updateTable:(NSString *)tbName removeColumns:(NSArray *)columns __deprecated;

/**
 是否存在表
 */
-(BOOL)isExistTable:(NSString *)tbName;

/**
 在表中是否存在符合条件的记录
 */
-(BOOL)isExistInTable:(NSString *)inName conditions:(NSDictionary *)conditions;
@end

