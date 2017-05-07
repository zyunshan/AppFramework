//
//  TestModel.m
//  AppFramework
//
//  Created by cnsunrun on 2017/3/31.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

+(NSDictionary *)mj_objectClassInArray{
    return @{ @"list": [Model1 class]};
}
@end

@implementation Model1

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"p_id": @"id"};
}

@end
