//
//  UITextView+Custom.m
//  AppFramework
//
//  Created by cnsunrun on 2017/4/1.
//  Copyright © 2017年 yunshan. All rights reserved.
//

#import "UITextView+Custom.h"
#import <objc/runtime.h>

@implementation UITextView (Custom)

-(void)setMaxInputLength:(NSInteger)maxInputLength{
    [self addTextViewNotification];
    objc_setAssociatedObject(self, "maxInputLength", @(maxInputLength), OBJC_ASSOCIATION_ASSIGN);
}

-(NSInteger)maxInputLength{
    return [objc_getAssociatedObject(self, "maxInputLength") integerValue];
}

-(void)addTextViewNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChanged:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)textViewTextChanged:(NSNotification *)note{
    NSString *content = self.text;
    if (content.length > self.maxInputLength) {
        self.text = [content substringToIndex:self.maxInputLength];
    }
}

-(void)config{
    
}

@end
