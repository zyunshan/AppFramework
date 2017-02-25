//
//  UIAlertController+Custom.m
//  AppFramework
//
//  Created by cnsunrun on 2017/2/25.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "UIAlertController+Custom.h"

@implementation UIAlertController (Custom)

-(void)addItems:(NSArray <NSString *>*)items block:(void(^)(NSInteger index))block{
    for (NSInteger i = 0; i < items.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:items[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(i);
        }];
        [self addAction:action];
    }
}

-(void)addItem:(NSString *)item style:(UIAlertActionStyle)style block:(void(^)())block{
    UIAlertAction *action = [UIAlertAction actionWithTitle:item style:style handler:^(UIAlertAction * _Nonnull action) {
        block();
    }];
    [self addAction:action];
}

-(void)addCancelItem:(NSString *)item{
    [self addItem:item style:UIAlertActionStyleCancel block:nil];
}
@end
