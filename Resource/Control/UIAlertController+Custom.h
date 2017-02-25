//
//  UIAlertController+Custom.h
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Custom)

-(void)addItems:(NSArray <NSString *>*)items block:(void(^)(NSInteger index))block;

-(void)addItem:(NSString *)item style:(UIAlertActionStyle)style block:(void(^)())block;

-(void)addCancelItem:(NSString *)item;
@end
