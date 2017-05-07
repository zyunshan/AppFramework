//
//  DBManager.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/17.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
{
    NSMutableDictionary *cacheInfo;//存储部分查询信息
}
+(instancetype)manager;

/**
 创建表名,如果已存在则不会创建
 */
-(void)creatTableWithClass:(Class)clss primaryKey:(NSString *)key;

/**
 插入对象
 */
-(void)insertModel:(id)model;

/**
  从指定表中删除符合条件的记录
 */
-(void)deleteModelFromTable:(NSString *)tbName condition:(NSDictionary *)conditions;

/**
 根据条件更新记录
 */
-(void)updateModel:(id)model condition:(NSDictionary *)conditions;

/**
 根据条件查询
 */
-(void)seachFromTable:(NSString *)tbName condition:(NSDictionary *)conditions completionHandle:(void(^)(NSMutableArray *results))completion;

/**
 打开数据库
 */
-(void)openDatabase;


/**
 关闭数据库
 */
-(void)closeDatabase;

@end
