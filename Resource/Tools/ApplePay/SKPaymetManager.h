//
//  SKPaymetManager.h
//  DogFoodApp
//
//  Created by cnsunrun on 2017/6/1.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKPaymetManager : NSObject

+(instancetype)shareManager;

-(void)requestProduct:(NSString *)productId;
@end
