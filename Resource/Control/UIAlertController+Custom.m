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
        if (block) {
           block();
        }
    }];
    [self addAction:action];
}


+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel others:(NSArray <NSString *> *)others block:(void (^)(NSInteger index))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    [alertController addItems:others block:^(NSInteger index) {
        block(index);
    }];
    
    if (cancel) {
        [alertController addItem:cancel style:UIAlertActionStyleCancel block:nil];
    }
    return alertController;
}

+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel others:(NSArray *)others objectForKey:(NSString *)key block:(void (^)(NSInteger index, id obj))block{
    NSMutableArray *titles = [NSMutableArray new];
    for (NSInteger i = 0; i<others.count; i++) {
        id object = others[i];
        if ([object isKindOfClass:[NSString class]]) {
            [titles addObject:object];
        }else if ([object isKindOfClass:[NSDictionary class]]){
            [titles addObject:object[key]];
        }else{
            [titles addObject:[object valueForKey:key]];
        }
    }
    UIAlertController *alertController = [UIAlertController alertWithTitle:title message:message style:style cancel:cancel others:titles block:^(NSInteger index) {
        block(index, others[index]);
    }];
    return alertController;
}
@end
