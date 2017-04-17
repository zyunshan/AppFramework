//
//  TestModel.h
//  AppFramework
//
//  Created by cnsunrun on 2017/3/31.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class Model1;
@interface TestModel : NSObject

@property (nonatomic, copy) NSString *first_char;

@property (nonatomic, copy) NSArray *list;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) BOOL sex;
@end

@interface Model1 : NSObject
@property (nonatomic, copy) NSString *p_id;

@property (nonatomic, copy) NSString *title;
@end
