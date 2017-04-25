//
//  UIControl+button.m
//  App
//
//  Created by huanchi on 15/10/27.
//  Copyright © 2015年  上海欢炽网络科技有限公司. All rights reserved.
//

#import "UIControl+Button.h"

static void *accepteEventIntervalProperty = (void *)@"accepteEventIntervalProperty";

static void *acceptedEventTimeProperty = (void *)@"acceptedEventTimeProperty";

@implementation UIControl (Button)


- (NSTimeInterval)acceptEventInterval{
    return [objc_getAssociatedObject(self, accepteEventIntervalProperty) doubleValue];
}

-(void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    objc_setAssociatedObject(self, accepteEventIntervalProperty, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptedEventTime{
    return [objc_getAssociatedObject(self, acceptedEventTimeProperty) doubleValue];
}

-(void)setAcceptedEventTime:(NSTimeInterval)acceptedEventTime{
    objc_setAssociatedObject(self, acceptedEventTimeProperty, @(acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.acceptedEventTime < self.acceptEventInterval) return;
    if (self.acceptEventInterval > 0){
        self.acceptedEventTime = NSDate.date.timeIntervalSince1970;
    }
    [self custom_sendAction:action to:target forEvent:event];
}
@end

@implementation UIButton (Custom)

- (TouchUpInsideEvent)clickEvent{
    return objc_getAssociatedObject(self, "clickEvent");
}

-(void)setClickEvent:(TouchUpInsideEvent)clickEvent{
    objc_setAssociatedObject(self, "clickEvent", clickEvent, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClickAction:(UIButton *)button{
    if (self.clickEvent) {
        self.clickEvent();
    }
}
@end
