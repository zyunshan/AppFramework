//
//  TouchIDTool.h
//  AppFramework
//
//  Created by cnsunrun on 2017/6/6.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouchIDTool : NSObject

+(void)authenticate:(void(^)())succ error:(void (^)(NSString *errMsg))failure;
@end
