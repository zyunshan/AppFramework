//
//  UITextView+Custom.h
//  AppFramework
//
//  Created by cnsunrun on 2017/4/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Custom)

@property (nonatomic, assign) NSInteger maxInputLength;

-(void)config;

@end
